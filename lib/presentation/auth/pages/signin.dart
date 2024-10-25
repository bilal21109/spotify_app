import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/appbar/app_bar.dart';
import 'package:spotify_app/common/widegts/buttons/basic_app_button.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';
import 'package:spotify_app/presentation/auth/pages/signup.dart';
import 'package:spotify_app/presentation/home/pages/home.dart';

import '../../../data/models/auth/sigin_user_acc.dart';
import '../../../domain/usecases/auth/signin.dart';
import '../../../service_locator.dart';

class SigninPage extends StatelessWidget {
   SigninPage({super.key});

   final TextEditingController _email=TextEditingController();
   final TextEditingController _password=TextEditingController();


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              SizedBox(height: 40),
              _fullNameField(context),
              SizedBox(
                height: 40,
              ),
              // _emailField(context),

              _passwordField(context),
              SizedBox(
                height: 70,
              ),
              BasicAppButton(
                  title: 'Sign In',
                  onPressed: () async{
                    var result= await sl<SigninUseCase>().call(
                        parameters:SigninUserAcc(
                            email: _email.text.toString(),
                            password: _password.text.toString()
                        )
                    );
                    result.fold(
                            (l){
                          var snakbar= SnackBar(content: Text(l));
                          ScaffoldMessenger.of(context).showSnackBar(snakbar);
                        },
                            (r){
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (BuildContext context)=>HomePage()),
                                  (route)=>false
                          );
                        }
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(hintText: 'Enter Username or Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  // Widget _emailField(BuildContext context) {
  //   return TextField(
  //     decoration: InputDecoration(hintText: 'Enter Email')
  //         .applyDefaults(Theme.of(context).inputDecorationTheme),
  //   );
  // }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(hintText: 'Password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(
          vertical: 30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const Text('NOt A Member?',style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500
        ),
        ),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SignupPage()));
          }, child: const Text('Register now'))
        ],
      ),
    );
  }
}
