import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/badge.dart';
import 'package:spejder_app/model/group.dart';
import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/badge_repository.dart';
import 'package:spejder_app/repositories/group_repository.dart';
import 'package:spejder_app/repositories/rank_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';

class Repository {
  Future<void> loadConstants() async {
    final ranks = await GetIt.instance.get<RankRepository>().getRanks();
    GetIt.instance.registerSingleton<List<Rank>>(ranks);
    final badges = await GetIt.instance.get<BadgeRepository>().getAllBadges();
    GetIt.instance.registerSingleton<List<Badge>>(badges);
    final groups = await GetIt.instance.get<GroupRepository>().getGroups();
    GetIt.instance.registerSingleton<List<Group>>(groups);

    final users = await GetIt.instance.get<UserProfileRepository>().getAllUsers();
    GetIt.instance.registerSingleton<List<UserProfile>>(users);
  }
}
