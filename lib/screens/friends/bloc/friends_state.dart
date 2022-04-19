part of 'friends_bloc.dart';

enum FriendsStateStatus { loading, loaded }

class FriendsState extends Equatable {
  final UserProfile userProfile;
  final FriendsStateStatus friendsStatus;
  final List<UserProfile> allUsers;
  final List<UserProfile> allUserFriends;

  const FriendsState({
    required this.userProfile,
    this.friendsStatus = FriendsStateStatus.loading,
    this.allUsers = const [],
    this.allUserFriends = const [],
  });

  @override
  List<Object> get props => [userProfile, friendsStatus, allUsers, allUserFriends];

  FriendsState copyWith({
    UserProfile? userProfile,
    FriendsStateStatus? friendsStatus,
    List<UserProfile>? allUsers,
    List<UserProfile>? allUserFriends,
  }) {
    return FriendsState(
      userProfile: userProfile ?? this.userProfile,
      friendsStatus: friendsStatus ?? this.friendsStatus,
      allUsers: allUsers ?? this.allUsers,
      allUserFriends: allUserFriends ?? this.allUserFriends,
    );
  }
}

//class FriendsInitial extends FriendsState {}
