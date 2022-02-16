part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final List<Badge> badges;
  final List<UserProfile> friends;

  const ProfileState({this.badges = const [], this.friends = const []});

  ProfileState copyWith({
    List<Badge>? badges,
    List<UserProfile>? friends,
  }) {
    return ProfileState(
      badges: badges ?? this.badges,
      friends: friends ?? this.friends,
    );
  }

  @override
  List<Object> get props => [badges, friends];
}
