import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/models/auth/create_user_acc.dart';
import 'package:spotify_app/data/models/auth/sigin_user_acc.dart';

abstract class AuthRepository{
  Future<Either> signup(CreateUserAcc createUserAcc);
  Future<Either> signin(SigninUserAcc signinUserAcc);

}