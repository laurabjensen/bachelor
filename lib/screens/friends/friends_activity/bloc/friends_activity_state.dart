part of 'friends_activity_bloc.dart';

class FriendsActivityState extends Equatable {
  final UserProfile userProfile;
  final List<UserProfile> userProfiles;

  const FriendsActivityState({required this.userProfile, this.userProfiles = const []});

  @override
  List<Object> get props => [userProfile, userProfiles];

  FriendsActivityState copyWith({
    UserProfile? userProfile,
    List<UserProfile>? userProfiles,
  }) {
    return FriendsActivityState(
      userProfile: userProfile ?? this.userProfile,
      userProfiles: userProfiles ?? this.userProfiles,
    );
  }
}
