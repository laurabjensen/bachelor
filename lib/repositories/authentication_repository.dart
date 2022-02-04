import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/screens/signup/bloc/signup_bloc.dart';

import '../custom_exception.dart';

class AuthenticationRepository {
  Future<User> createUserFromSignupState(SignupState state) async {
    try {
      final user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: state.email, password: state.password))
          .user;
      if (user != null) {
        return user;
      } else {
        throw CustomException('Bruger ikke oprettet');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException('Svagt kodeord - Vælg andet');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException('Der er allerede en bruger med denne email');
      } else {
        throw CustomException('Bruger ikke oprettet');
      }
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  addUserToFirebaseFromSignupState(User user, SignupState state) async {
    final userProfile = UserProfile(
        id: user.uid,
        email: state.email,
        name: state.name,
        group: state.group,
        rank: state.rank,
        seniority: 0);
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userProfile.toJson());
  }
}
