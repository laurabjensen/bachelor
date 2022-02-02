import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  EditprofileBloc() : super(EditprofileInitial());

  @override
  Stream<EditprofileState> mapEventToState(
    EditprofileEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
