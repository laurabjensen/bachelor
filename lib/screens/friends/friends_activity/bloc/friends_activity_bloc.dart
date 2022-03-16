import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'friends_activity_event.dart';
part 'friends_activity_state.dart';

class FriendsActivityBloc extends Bloc<FriendsActivityEvent, FriendsActivityState> {
  FriendsActivityBloc() : super(FriendsActivityInitial()) {
    on<FriendsActivityEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
