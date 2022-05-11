import 'dart:async';

import 'package:flutter/material.dart';
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
    GetIt.instance
        .registerSingleton<List<Rank>>(await GetIt.instance.get<RankRepository>().getRanks());
    final rankStream = GetIt.instance.get<RankRepository>().getRanksStream();
    StreamController<List<Rank>> rankController = StreamController();
    rankController.addStream(rankStream);
    rankController.stream.listen((event) {
      GetIt.instance.registerSingleton<List<Rank>>(event);
    });

    final badges = await GetIt.instance.get<BadgeRepository>().getAllBadges();
    GetIt.instance.registerSingleton<List<Badge>>(badges);

    GetIt.instance
        .registerSingleton<List<Group>>(await GetIt.instance.get<GroupRepository>().getGroups());
    final groupStream = GetIt.instance.get<GroupRepository>().getGroupsStream();
    StreamController<List<Group>> groupController = StreamController();
    groupController.addStream(groupStream);
    groupController.stream.listen((event) {
      GetIt.instance.registerSingleton<List<Group>>(event);
    });

    /*GetIt.instance.registerSingleton<List<UserProfile>>(
        await GetIt.instance.get<UserProfileRepository>().getAllUsers());
    final userStream = GetIt.instance.get<UserProfileRepository>().getAllUsersStream();
    StreamController<List<UserProfile>> userController = StreamController();
    userController.addStream(userStream);
    StreamController<List<UserProfile>> publicUserController = StreamController();
    GetIt.instance.registerSingleton<StreamController<List<UserProfile>>>(publicUserController);
    userController.stream.listen((event) async {
      var users = <UserProfile>[];
      for (var e in event) {
        users.add(await GetIt.instance.get<UserProfileRepository>().getUserprofile(e));
      }
      publicUserController.add(users);
      GetIt.instance.registerSingleton<List<UserProfile>>(users);
    });*/
  }
}
