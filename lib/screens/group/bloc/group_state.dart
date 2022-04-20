part of 'group_bloc.dart';

enum GroupLoadStatus { loading, loaded }

@immutable
class GroupState extends Equatable {
  final UserProfile userProfile;
  final List<UserProfile> groupMembers;
  final GroupLoadStatus loadStatus;

  const GroupState(
      {required this.userProfile,
      this.groupMembers = const [],
      this.loadStatus = GroupLoadStatus.loading});

  GroupState copyWith({
    UserProfile? userProfile,
    List<UserProfile>? groupMembers,
    GroupLoadStatus? loadStatus,
  }) {
    return GroupState(
      userProfile: userProfile ?? this.userProfile,
      groupMembers: groupMembers ?? this.groupMembers,
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  @override
  List<Object?> get props => [userProfile, groupMembers, loadStatus];
}
