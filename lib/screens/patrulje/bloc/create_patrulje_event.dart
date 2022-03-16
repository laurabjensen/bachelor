part of 'create_patrulje_bloc.dart';

abstract class CreatePatruljeEvent extends Equatable {
  const CreatePatruljeEvent();

  @override
  List<Object> get props => [];
}

class LoadFromFirebase extends CreatePatruljeEvent {
  const LoadFromFirebase();
}

class RankChanged extends CreatePatruljeEvent {
  final Rank? rank;

  const RankChanged(this.rank);
}

//TODO! DO we need this?
class UpdateFailure extends CreatePatruljeEvent {
  final String failureMessage;

  const UpdateFailure(this.failureMessage);
}
