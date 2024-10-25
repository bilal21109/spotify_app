import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/common/helpers/is_dark_mode.dart';
import 'package:spotify_app/core/configs/assets/app_images.dart';
import 'package:spotify_app/core/theme/app_colors.dart';
import 'package:spotify_app/presentation/home/widgets/news_songs.dart';
import 'package:spotify_app/presentation/home/widgets/play_list.dart';
import '../../../common/appbar/app_bar.dart';
import '../../../core/configs/assets/app_vectors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTOpCard(),
            _tabs(),
            SizedBox(
              height: 250,
             child:TabBarView(
              controller: _tabController,
                children:[
                  NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ]
            )
            ),
            const SizedBox(
              height: 40,
            ),
            const PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTOpCard() {
    return Center(
        child: SizedBox(
      height: 140,
          child: Stack(
              children: [
           Align(
             alignment: Alignment.bottomCenter,
             child: SvgPicture.asset(
                 AppVectors.homeTopCard
             ),
           ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 60
                    ),
                    child: Image.asset(
                      AppImages.homeArtist
                    ),
                  ),
                )
      ]
          ),
    )
    );
  }

  Widget _tabs(){
    return TabBar(
      controller: _tabController,
        isScrollable: true,
        labelColor: context.isDarkMode ?Colors.white:Colors.black,
        indicatorColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 0
        ),
        tabs: const [
         Text('News',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
          Text('Videos',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
          Text('Artists',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
          Text('Podcasts',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
        ]
    );
  }
}
