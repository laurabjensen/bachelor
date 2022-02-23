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
  final UserProfile userprofile;
  const UpdatePressed(this.userprofile);
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

class NewImageFile extends EditprofileEvent {
  final File? image;

  const NewImageFile(this.image);
}
