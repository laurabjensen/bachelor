part of 'create_patrol_bloc.dart';

enum CreatePatrolStateStatus { initial, loading, success, failure }

@immutable
class CreatePatrolState extends Equatable {
  final CreatePatrolStateStatus createPatrolStatus;
  final UserProfile userProfile;
  final String createPatrolStatusMessage;
  final List<UserProfile> userProfiles;
  final List<UserProfile> selectedUserProfiles;

  const CreatePatrolState({
    this.createPatrolStatus = CreatePatrolStateStatus.initial,
    required this.userProfile,
    this.createPatrolStatusMessage = '',
    this.userProfiles = const [],
    this.selectedUserProfiles = const [],
  });

  CreatePatrolState copyWith({
    CreatePatrolStateStatus? createPatrolStatus,
    UserProfile? userProfile,
    String? createPatrolStatusMessage,
    List<UserProfile>? userProfiles,
    List<UserProfile>? selectedUserProfiles,
  }) {
    return CreatePatrolState(
      createPatrolStatus: createPatrolStatus ?? this.createPatrolStatus,
      userProfile: userProfile ?? this.userProfile,
      createPatrolStatusMessage: createPatrolStatusMessage ?? this.createPatrolStatusMessage,
      userProfiles: userProfiles ?? this.userProfiles,
      selectedUserProfiles: selectedUserProfiles ?? this.selectedUserProfiles,
    );
  }

  @override
  List<Object> get props => [
        createPatrolStatus,
        userProfile,
        createPatrolStatusMessage,
        userProfiles,
        selectedUserProfiles
      ];
}
