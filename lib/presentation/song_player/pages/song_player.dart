import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/appbar/app_bar.dart';
import 'package:spotify_app/core/theme/app_colors.dart';
import 'package:spotify_app/domain/entities/song/song.dart';
import 'package:spotify_app/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_app/presentation/song_player/bloc/song_player_state.dart';

import '../../../core/configs/constants/app_urls.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now playing',
          style: TextStyle(fontSize: 18),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_outlined),
        ),
      ),
      body: BlocProvider(
       create: (_) => SongPlayerCubit()..loadSong(
           "${AppURLs.songfireStorage}${songEntity.artist} - ${songEntity.title!.trim()}.mp3?${AppURLs.mediaAlt}&${AppURLs.token}"
       ),
        child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            _songCover(context),
            SizedBox(
              height: 20,
            ),
            _songDetail(),
            SizedBox(
              height: 20,
            ),
            _songPlayer(context)
          ],
        ),
      ),
),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(
                //"${AppURLs.fireStorage}${songEntity.artist} - ${songEntity.title!.trim()}.jpg?${AppURLs.mediaAlt}&${AppURLs.token}"))),
                'https://firebasestorage.googleapis.com/v0/b/spotify-app-71669.appspot.com/o/covers%2FBillie%20Eilish%20%2C%20Khalid%20-%20lovely.jpg?alt=media&token=9e78d483-2eb7-4e9c-8dd9-bf21dfa79d45'))));
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              songEntity.artist,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            ),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline_outlined,
              color: AppColors.darkGrey,
              size: 35,
            ))
      ],
    );
  }
  Widget _songPlayer(BuildContext context){
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
        builder:(context, state){
          if(state is SongPlayerLoading){
            return CircularProgressIndicator();
          }
          if(state is SongPlayerLoaded){
            return Column(
              children: [
                Slider(
                    value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                    min: 0.0,
                    max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                    onChanged: (value){}
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('data')
                  ],
                )
              ],
            );
          }
          return Container();
        }
    );
  }


}
