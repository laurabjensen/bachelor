part of 'group_bloc.dart';

enum GroupLoadStatus { loading, loaded }

@immutable
class GroupState extends Equatable {
  final UserProfile userProfile;
  final List<UserProfile> groupMembers;
  final GroupLoadStatus loadStatus;
  final List<Patrol> patrols;

  const GroupState(
      {required this.userProfile,
      this.groupMembers = const [],
      this.loadStatus = GroupLoadStatus.loading,
      this.patrols = const []});

  GroupState copyWith({
    UserProfile? userProfile,
    List<UserProfile>? groupMembers,
    GroupLoadStatus? loadStatus,
    List<Patrol>? patrols,
  }) {
    return GroupState(
      userProfile: userProfile ?? this.userProfile,
      groupMembers: groupMembers ?? this.groupMembers,
      loadStatus: loadStatus ?? this.loadStatus,
      patrols: patrols ?? this.patrols,
    );
  }

  @override
  List<Object?> get props => [userProfile, groupMembers, loadStatus, patrols];
}
