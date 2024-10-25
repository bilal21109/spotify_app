
import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/data/models/auth/create_user_acc.dart';

import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SignUpUseCase implements UseCase<Either,CreateUserAcc>{

  @override
  Future<Either> call({ CreateUserAcc ? parameters}) async {
    return sl<AuthRepository>().signup(parameters!);
  }

}