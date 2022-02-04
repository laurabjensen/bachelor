import 'package:firebase_auth/firebase_auth.dart';
import 'package:spejder_app/screens/signup/bloc/signup_bloc.dart';

import '../custom_exception.dart';

class LoginRepository {
  Future<void> createUserFromSignupState(SignupState state) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: state.email, password: state.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException('Svagt kodeord - Vælg andet');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException('Der er allerede en bruger med denne email');
      }
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
