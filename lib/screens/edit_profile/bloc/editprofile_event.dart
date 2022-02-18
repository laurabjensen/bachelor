part of 'editprofile_bloc.dart';

abstract class EditprofileEvent extends Equatable {
  const EditprofileEvent();

  @override
  List<Object> get props => [];
}

class LoadFromFirebase extends EditprofileEvent {
  const LoadFromFirebase();
}

class UpdatePressed extends EditprofileEvent {
  const UpdatePressed();
}

class NameChanged extends EditprofileEvent {
  final String name;

  const NameChanged(this.name);
}

class AgeChanged extends EditprofileEvent {
  final int age;

  const AgeChanged(this.age);
}

class DescriptionChanged extends EditprofileEvent {}

class GroupChanged extends EditprofileEvent {
  final String? group;

  const GroupChanged(this.group);
}

class RankChanged extends EditprofileEvent {
  final Rank? rank;

  const RankChanged(this.rank);
}

class UpdateFailure extends EditprofileEvent {
  final String failureMessage;

  const UpdateFailure(this.failureMessage);
}
