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
        throw CustomException('Der skete en fejl. Prøv igen');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException('Bruger ikke fundet for den email');
      } else if (e.code == 'wrong-password') {
        throw CustomException('Forkert kodeord');
      } else if (e.code == 'user-disabled') {
        throw CustomException('Bruger er deaktiveret');
      } else if (e.code == 'invalid-email') {
        throw CustomException('Ugyldig email');
      } else if (e.code == 'too-many-requests') {
        throw CustomException('For mange login forsøg. Prøv igen senere');
      } else {
        throw CustomException('Der skete en fejl. Prøv igen');
      }
    }
  }
}
