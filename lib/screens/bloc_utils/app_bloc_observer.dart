import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spejder_app/screens/feed/post/bloc/post_bloc.dart';

import '../../logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    bloc is PostBloc ? null : logger.d('onChange($bloc, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.d('onError($bloc, $error, $stackTrace)');
  }
}
