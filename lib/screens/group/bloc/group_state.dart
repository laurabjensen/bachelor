part of 'group_bloc.dart';

enum GroupLoadStatus { loading, loaded }

@immutable
class GroupState extends Equatable {
  final List<UserProfile> groupMembers;
  final GroupLoadStatus loadStatus;

  const GroupState({this.groupMembers = const [], this.loadStatus = GroupLoadStatus.loading});

  GroupState copyWith({
    List<UserProfile>? groupMembers,
    GroupLoadStatus? loadStatus,
  }) {
    return GroupState(
      groupMembers: groupMembers ?? this.groupMembers,
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  @override
  List<Object?> get props => [groupMembers, loadStatus];
}
