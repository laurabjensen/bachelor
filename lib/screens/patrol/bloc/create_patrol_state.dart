part of 'create_patrol_bloc.dart';

enum CreatePatrolStateStatus { initial, loading, success, failure }

@immutable
class CreatePatrolState extends Equatable {
  final CreatePatrolStateStatus createPatrolStatus;
  final String createPatrolStatusMessage;
  final List<UserProfile> userProfiles;
  final List<UserProfile> selectedUserProfiles;

  const CreatePatrolState({
    this.createPatrolStatus = CreatePatrolStateStatus.initial,
    this.createPatrolStatusMessage = '',
    this.userProfiles = const [],
    this.selectedUserProfiles = const [],
  });

  CreatePatrolState copyWith({
    CreatePatrolStateStatus? createPatrolStatus,
    String? createPatrolStatusMessage,
    List<UserProfile>? userProfiles,
    List<UserProfile>? selectedUserProfiles,
  }) {
    return CreatePatrolState(
      createPatrolStatus: createPatrolStatus ?? this.createPatrolStatus,
      createPatrolStatusMessage: createPatrolStatusMessage ?? this.createPatrolStatusMessage,
      userProfiles: userProfiles ?? this.userProfiles,
      selectedUserProfiles: selectedUserProfiles ?? this.selectedUserProfiles,
    );
  }

  @override
  List<Object> get props =>
      [createPatrolStatus, createPatrolStatusMessage, userProfiles, selectedUserProfiles];
}
