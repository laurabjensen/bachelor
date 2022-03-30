part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final List<Post> posts;
  final List<UserProfile> friends;
  final UserProfile userProfile;

  const ProfileState({this.posts = const [], this.friends = const [], required this.userProfile});

  ProfileState copyWith({List<Post>? posts, List<UserProfile>? friends, UserProfile? userProfile}) {
    return ProfileState(
        posts: posts ?? this.posts,
        friends: friends ?? this.friends,
        userProfile: userProfile ?? this.userProfile);
  }

  @override
  List<Object> get props => [posts, friends, userProfile];
}
