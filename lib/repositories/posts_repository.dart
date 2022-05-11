import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge_registration.dart';
import 'package:spejder_app/model/post.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_registration_repository.dart';
import 'package:collection/collection.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

class PostsRepository {
  final BadgeRegistrationRepository badgeRegistrationRepository =
      GetIt.instance.get<BadgeRegistrationRepository>();
  final UserProfileRepository userProfileRepository = GetIt.instance.get<UserProfileRepository>();
  Future<String> createPost(BadgeRegistration badgeRegistration) async {
    var post = Post(
        id: '',
        badgeRegistration: badgeRegistration,
        likes: [],
        comments: [],
        approvedAt: badgeRegistration.approvedAt,
        user: badgeRegistration.userProfileId);
    var snap = await FirebaseFirestore.instance.collection('posts').add(post.toMap());
    return snap.id;
  }

  Stream<Post> getPost(String postId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .snapshots()
        .map((snapshot) => Post.fromJson(snapshot));
  }

  Future<Post> getPostFromId(String postId) async {
    var snap = await FirebaseFirestore.instance.collection('posts').doc(postId).get();
    var post = Post.fromJson(snap);
    final badgeRegistration =
        await badgeRegistrationRepository.getBadgeRegistrationFromId(snap.get('badgeRegistration'));
    return post.copyWith(badgeRegistration: badgeRegistration);
  }

  Future<Post> getPostFromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snap) async {
    var post = Post.fromJson(snap);
    var badgeRegistration =
        await badgeRegistrationRepository.getBadgeRegistrationFromId(snap.get('badgeRegistration'));
    badgeRegistration = badgeRegistration.copyWith(
        userProfile:
            await userProfileRepository.getUserprofileFromId(badgeRegistration.userProfileId));
    return post.copyWith(badgeRegistration: badgeRegistration);
  }

  Future<List<Post>> getPostsFromUserProfile(UserProfile userProfile) async {
    var posts = <Post>[];
    for (var post in userProfile.posts) {
      posts.add(await getPostFromId(post));
    }
    posts
        .sort((a, b) => b.badgeRegistration.approvedAt!.compareTo(a.badgeRegistration.approvedAt!));
    return posts;
  }

  Future<List<Post>> getPostsForUserFriends(UserProfile userProfile) async {
    var friendList = userProfile.friends.toList();
    friendList.add(userProfile.id);
    var list = <Post>[];

    var snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('approvedAt', descending: true)
        .where('user', whereIn: friendList)
        .get();
    for (var snap in snapshot.docs) {
      var post = await getPostFromId(snap.id);
      var registration = post.badgeRegistration.copyWith(
          userProfile: await userProfileRepository
              .getUserprofileFromId(post.badgeRegistration.userProfileId));
      list.add(post.copyWith(badgeRegistration: registration));
    }
    //friends.remove(userProfile.id);
    return list;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getFeedSnapshotsForUser(
      UserProfile userProfile) async {
    var friendList = userProfile.friends.toList();
    friendList.add(userProfile.id);

    return (await FirebaseFirestore.instance
            .collection('posts')
            .orderBy('approvedAt', descending: true)
            .where('user', whereIn: friendList)
            .get())
        .docs;
  }

  Future<Post> toggleLikesForPost(bool isLiked, Post post, String userId) async {
    if (isLiked) {
      var likes = List<String>.from(
          (await FirebaseFirestore.instance.collection('posts').doc(post.id).get()).get('likes'));
      likes.add(userId);
      post = post.copyWith(likes: likes);
      await FirebaseFirestore.instance.collection('posts').doc(post.id).update({'likes': likes});
    } else {
      var likes = List<String>.from(
          (await FirebaseFirestore.instance.collection('posts').doc(post.id).get()).get('likes'));
      likes.remove(userId);
      post = post.copyWith(likes: likes);
      await FirebaseFirestore.instance.collection('posts').doc(post.id).update({'likes': likes});
    }
    return post;
  }
}
