part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final List<Badge> badges;
  final List<UserProfile> friends;
  final UserProfile userProfile;

  const ProfileState(
      {this.badges = const [],
      this.friends = const [],
      required this.userProfile});

  ProfileState copyWith(
      {List<Badge>? badges,
      List<UserProfile>? friends,
      UserProfile? userProfile}) {
    return ProfileState(
        badges: badges ?? this.badges,
        friends: friends ?? this.friends,
        userProfile: userProfile ?? this.userProfile);
  }

  @override
  List<Object> get props => [badges, friends, userProfile];
}
