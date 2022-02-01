import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:spejder_app/screen.dart';
import 'package:equatable/equatable.dart';

import 'screens/bloc_utils/app_bloc_observer.dart';

Future<void> main() async {
  await BlocOverrides.runZoned(
    () async {
      EquatableConfig.stringify = true;

      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();

      //setupDi();
      Logger.level = Level.verbose;
      runZonedGuarded(() {
        runApp(const MyApp());
      }, (error, stackTrace) {
        //logger.e('runZonedGuarded: Caught error in my root zone: ', error);
        //FirebaseCrashlytics.instance.recordError(error, stackTrace);
      });
    },
    blocObserver: AppBlocObserver(),
  );
}
