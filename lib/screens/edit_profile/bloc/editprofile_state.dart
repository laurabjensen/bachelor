part of 'editprofile_bloc.dart';

enum EditprofileStateStatus { initial, loading, success, failure }

@immutable
class EditprofileState extends Equatable {
  final EditprofileStateStatus editprofileStatus;
  final Group? group;
  final Rank? rank;
  final List<Group> groups;
  final List<Rank> ranks;
  final File? imageFile;
  final UserProfile userprofile;

  const EditprofileState(
      {this.editprofileStatus = EditprofileStateStatus.initial,
      this.group,
      this.rank,
      this.groups = const <Group>[],
      this.ranks = const <Rank>[],
      this.imageFile,
      required this.userprofile});

  EditprofileState copyWith(
      {EditprofileStateStatus? editprofileStatus,
      Group? group,
      Rank? rank,
      List<Group>? groups,
      List<Rank>? ranks,
      File? imageFile,
      UserProfile? userprofile}) {
    return EditprofileState(
        editprofileStatus: editprofileStatus ?? this.editprofileStatus,
        group: group ?? this.group,
        rank: rank ?? this.rank,
        groups: groups ?? this.groups,
        ranks: ranks ?? this.ranks,
        imageFile: imageFile ?? this.imageFile,
        userprofile: userprofile ?? this.userprofile);
  }

  @override
  List<Object> get props => [
        editprofileStatus,
        rank?.title ?? '',
        group?.name ?? '',
        imageFile?.path ?? '',
      ];
}
