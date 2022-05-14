import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

part 'friends_activity_event.dart';
part 'friends_activity_state.dart';

class FriendsActivityBloc extends Bloc<FriendsActivityEvent, FriendsActivityState> {
  UserProfile userProfile;
  final userProfileRepository = GetIt.instance.get<UserProfileRepository>();

  FriendsActivityBloc(this.userProfile) : super(FriendsActivityState(userProfile: userProfile)) {
    on<StreamStarted>((event, emit) async {
      await emit.onEach<UserProfile>(
        userProfileRepository.getUser(userProfile.id),
        onData: (updatedUser) {
          userProfile = updatedUser;
          add(LoadUserprofiles());
        },
      );
    }, transformer: restartable());

    on<AcceptFriend>((event, emit) => _acceptFriend(event.sender, emit));
    on<RejectFriend>((event, emit) => _rejectFriend(event.sender, emit));
    on<LoadUserprofiles>((event, emit) => _loadUserprofiles(emit));

    add(StreamStarted());
  }

  Future<void> _acceptFriend(UserProfile sender, Emitter<FriendsActivityState> emit) async {
    await userProfileRepository.acceptFriendRequest(sender: sender, receiver: userProfile);
  }

  Future<void> _rejectFriend(UserProfile sender, Emitter<FriendsActivityState> emit) async {
    await userProfileRepository.cancelFriendRequest(sender: sender, receiver: userProfile);
  }

  Future<void> _loadUserprofiles(Emitter<FriendsActivityState> emit) async {
    final list =
        await userProfileRepository.getUserprofilesFromList(userProfile.friendRequestsReceived);
    emit(state.copyWith(userProfiles: list, userProfile: userProfile));
  }
}
