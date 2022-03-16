part of 'friends_bloc.dart';

enum FriendsStateStatus { loading, loaded }

class FriendsState extends Equatable {
  final FriendsStateStatus friendsStatus;
  final List<UserProfile> allUserFriends;

  const FriendsState({
    this.friendsStatus = FriendsStateStatus.loading,
    this.allUserFriends = const [],
  });

  @override
  List<Object> get props => [friendsStatus];

  FriendsState copyWith({
    FriendsStateStatus? friendsStatus,
    List<UserProfile>? allUserFriends,
  }) {
    return FriendsState(
      friendsStatus: friendsStatus ?? this.friendsStatus,
      allUserFriends: allUserFriends ?? this.allUserFriends,
    );
  }
}

//class FriendsInitial extends FriendsState {}
