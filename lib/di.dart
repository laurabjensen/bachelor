import 'package:get_it/get_it.dart';
import 'package:spejder_app/repositories/authentication_repository.dart';
import 'package:spejder_app/repositories/badge_registration_repository.dart';
import 'package:spejder_app/repositories/badge_repository.dart';
import 'package:spejder_app/repositories/posts_repository.dart';
import 'package:spejder_app/repositories/group_repository.dart';
import 'package:spejder_app/repositories/image_repository.dart';
import 'package:spejder_app/repositories/login_repository.dart';
import 'package:spejder_app/repositories/rank_repository.dart';
import 'package:spejder_app/repositories/userprofile_repository.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';

// Initialiserer blocs og repositories som singletons
void setupDi() {
  final getIt = GetIt.instance;
  getIt.allowReassignment = true;

  getIt.registerLazySingleton(() => AuthenticationBloc(getIt.get(), getIt.get()));
  getIt.registerLazySingleton(() => AuthenticationRepository());
  getIt.registerLazySingleton(() => UserProfileRepository());
  getIt.registerLazySingleton(() => LoginRepository());
  getIt.registerLazySingleton(() => GroupRepository());
  getIt.registerLazySingleton(() => RankRepository());
  getIt.registerLazySingleton(() => BadgeRepository());
  getIt.registerLazySingleton(() => ImageRepository());
  getIt.registerLazySingleton(() => BadgeRegistrationRepository());
  getIt.registerLazySingleton(() => PostsRepository());
}
