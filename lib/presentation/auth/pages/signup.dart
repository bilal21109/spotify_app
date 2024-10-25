import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/appbar/app_bar.dart';
import 'package:spotify_app/common/widegts/buttons/basic_app_button.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';
import 'package:spotify_app/data/models/auth/create_user_acc.dart';
import 'package:spotify_app/domain/usecases/auth/signup.dart';
import 'package:spotify_app/presentation/auth/pages/signin.dart';
import 'package:spotify_app/presentation/home/pages/home.dart';

import '../../../service_locator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _fullName=TextEditingController();
  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
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
          scrollDirection: Axis.vertical ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              SizedBox(height: 40),
              _fullNameField(context),
              SizedBox(
                height: 40,
              ),
              _emailField(context),
              SizedBox(
                height: 40,
              ),
              _passwordField(context),
              SizedBox(
                height: 40,
              ),
              BasicAppButton(
                  title: 'Create Account',
                  onPressed: () async{
                var result= await sl<SignUpUseCase>().call(
                  parameters:CreateUserAcc(
                    fullName: _fullName.text.toString(),
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
              }
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: InputDecoration(hintText: 'Full Name')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(hintText: 'Password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(
        vertical: 30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Do you have an account?',style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500
        ),
        ),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SigninPage()));
          }, child: Text('Sign In'))
        ],
      ),
    );
  }
}
