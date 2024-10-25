import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/widegts/buttons/basic_app_button.dart';
import 'package:spotify_app/core/configs/assets/app_images.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';
import 'package:spotify_app/core/theme/app_colors.dart';
import 'package:spotify_app/presentation/choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage(AppImages.intoBG))),
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
            horizontal: 40,
                vertical: 40
          ),
          child:Column(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo)),
              Spacer(),
              Text(
                'Enjoy Listening to Music',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enjoy Listening to Music',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              BasicAppButton(
                  title: 'Get Started',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext contex) =>
                            const ChooseModePage()));
                  })
            ],
          ),
          )
        ],
      ),
    );
  }
}
