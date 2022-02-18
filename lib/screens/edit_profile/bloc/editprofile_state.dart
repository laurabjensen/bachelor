part of 'editprofile_bloc.dart';

enum EditprofileStateStatus { initial, loading, success, failure }

@immutable
class EditprofileState extends Equatable {
  final EditprofileStateStatus editprofileStatus;
  final String name;
  final int age;
  final Group group;
  final Rank rank;
  final List<Group> groups;
  final List<Rank> ranks;
  final String failureMessage;

  const EditprofileState(
      {this.editprofileStatus = EditprofileStateStatus.initial,
      this.name = '',
      this.age = 0,
      this.group = Group.empty,
      this.rank = Rank.empty,
      this.groups = const <Group>[],
      this.ranks = const <Rank>[],
      this.failureMessage = ''});

  EditprofileState copyWith(
      {EditprofileStateStatus? editprofileStatus,
      String? name,
      int? age,
      Group? group,
      Rank? rank,
      List<Group>? groups,
      List<Rank>? ranks,
      String? failureMessage}) {
    return EditprofileState(
        editprofileStatus: editprofileStatus ?? this.editprofileStatus,
        name: name ?? this.name,
        age: age ?? this.age,
        group: group ?? this.group,
        rank: rank ?? this.rank,
        groups: groups ?? this.groups,
        ranks: ranks ?? this.ranks,
        failureMessage: failureMessage ?? this.failureMessage);
  }

  @override
  List<Object> get props => [
        editprofileStatus,
        group.name,
        rank.title,
        name,
        age,
        groups,
        ranks,
      ];
}
