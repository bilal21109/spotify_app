
import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/data/models/auth/sigin_user_acc.dart';
import '../../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SigninUseCase implements UseCase<Either, SigninUserAcc>{

  @override
  Future<Either> call({ SigninUserAcc ? parameters}) async {
    return sl<AuthRepository>().signin(parameters!);
  }
}