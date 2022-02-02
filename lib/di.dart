import 'package:get_it/get_it.dart';
import 'package:spejder_app/screens/authentication/authentication_bloc.dart';

// Initialiserer blocs og repositories som singletons
void setupDi() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton(() => AuthenticationBloc());
}
