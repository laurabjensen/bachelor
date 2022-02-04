import 'package:firebase_auth/firebase_auth.dart';

import '../custom_exception.dart';

class LoginRepository {
  Future<User> signinUser(String email, String password) async {
    try {
      final user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password))
              .user;
      if (user != null) {
        return user;
      } else {
        throw CustomException('Bruger ikke fundet');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException('Bruger ikke fundet for den email');
      } else if (e.code == 'wrong-password') {
        throw CustomException('Forkert kodeord');
      } else {
        throw CustomException('Bruger ikke fundet');
      }
    }
  }
}
