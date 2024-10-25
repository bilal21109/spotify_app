import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/models/auth/create_user_acc.dart';
import 'package:spotify_app/data/models/auth/sigin_user_acc.dart';
import 'package:spotify_app/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signin(SigninUserAcc signinUserAcc) async{
    return await sl<AuthFirebaseService>().signin(signinUserAcc);
  }

  @override
  Future<Either> signup(CreateUserAcc createUserAcc) async{
   return await sl<AuthFirebaseService>().signup(createUserAcc);
  }

}
