import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:spejder_app/model/user_profile.dart';
import 'package:spejder_app/repositories/group_repository.dart';
import 'package:spejder_app/screens/signup/bloc/signup_bloc.dart';

import '../custom_exception.dart';

class AuthenticationRepository {
  Future<User> createUserFromSignupState(SignupState state) async {
    try {
      final user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: state.email, password: state.password))
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

  //TODO: age ikke lavet rigtigt
  Future<void> addUserToFirebaseFromSignupState(
      User user, SignupState state) async {
    final userProfile = UserProfile(
        id: user.uid,
        age: 0,
        email: state.email,
        name: state.name,
        group: state.group,
        rank: state.rank,
        seniority: 0,
        description: '',
        imageUrl: '',
        posts: [],
        friends: []);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(userProfile.toJson());
    await GetIt.instance
        .get<GroupRepository>()
        .addMemberToGroup(state.group, user.uid);
    state.rank.title == 'Leder'
        ? await GetIt.instance
            .get<GroupRepository>()
            .addLeaderToGroup(state.group, user.uid)
        : null;
  }

  Future<bool> isSignedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> signOut() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.signOut();
    }
  }
}
