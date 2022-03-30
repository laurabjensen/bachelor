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

  Future<Post> getPostFromId(String postId) async {
    var snap = await FirebaseFirestore.instance.collection('posts').doc(postId).get();
    var post = Post.fromJson(snap);
    final badgeRegistration =
        await badgeRegistrationRepository.getBadgeRegistrationFromId(snap.get('badgeRegistration'));
    return post.copyWith(badgeRegistration: badgeRegistration);
  }

  Future<List<Post>> getPostsFromUserProfile(UserProfile userProfile) async {
    var posts = <Post>[];
    for (var post in userProfile.posts) {
      posts.add(await getPostFromId(post));
    }
    return posts;
  }

  Future<List<Post>> getPostsForUserFriends(UserProfile userProfile) async {
    var friendList = userProfile.friends.toList();
    friendList.add(userProfile.id);
    var list = <Post>[];

    var snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('approvedAt')
        .where('user', whereIn: friendList)
        .get();
    for (var snap in snapshot.docs) {
      var post = await getPostFromId(snap.id);
      var registration = post.badgeRegistration.copyWith(
          userProfile: GetIt.instance.get<List<UserProfile>>().firstWhereOrNull(
                  (element) => element.id == post.badgeRegistration.userProfileId) ??
              await userProfileRepository
                  .getUserprofileFromId(post.badgeRegistration.userProfileId));
      list.add(post.copyWith(badgeRegistration: registration));
    }
    //friends.remove(userProfile.id);
    return list;
  }
}
