import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/data/models/auth/create_user_acc.dart';
import 'package:spotify_app/data/models/auth/sigin_user_acc.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserAcc createUserAcc);

  Future<Either> signin(SigninUserAcc signinUserAcc);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserAcc signinUserAcc) async {
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserAcc.email, password: signinUserAcc.password);

      return const Right("Sign in was Successful");
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'Not user found for that email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provider for that user';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserAcc createUserAcc) async {
    try {
     var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserAcc.email, password: createUserAcc.password);
      FirebaseFirestore.instance.collection('User').add(
          {
            'name': createUserAcc.fullName,
            'email': data.user?.email,
          }
      );
      return const Right("Sign up was Successful");
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'Week_password') {
        message = 'Password is to much week';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exits';
      }
      return Left(message);
    }
  }
}
