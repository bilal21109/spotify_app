import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/helpers/is_dark_mode.dart';
import 'package:spotify_app/core/theme/app_colors.dart';
import 'package:spotify_app/domain/entities/song/song.dart';
import 'package:spotify_app/presentation/home/bloc/play_list_cubit.dart';
import 'package:spotify_app/presentation/home/bloc/play_list_state.dart';

import '../../song_player/pages/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child:
          BlocBuilder<PlayListCubit, PlayListState>(builder: (context, state) {
        if (state is PlayListLoading) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }
        if (state is PlayListLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('PlayList',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('See More',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffC6C6C6)))
                  ],
                ),
                SizedBox(height: 20,),
                _song(state.songs)
              ],
            ),
          );
        }
        return Container();
      }),
    );
  }

  Widget _song(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SongPlayerPage(
                            songEntity: songs[index],
                          )));
                },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.isDarkMode?AppColors.darkGrey:Color(0xffE6E6E6)
                      ),
                      child: Icon(Icons.play_arrow_rounded,
                      color: context.isDarkMode?Color(0xff959595):Color(0x555555),
                      ),
                    ),
                    SizedBox(width: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songs[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          songs[index].artist,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 10
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                children: [
                  Text(
                    songs[index].duration.toString().replaceAll('.', ':')
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(onPressed: (){
                  },
                      icon: Icon(
                        Icons.favorite_outline_outlined,
                        color: AppColors.darkGrey,
                        size: 25,
                      )
                  )
                ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              height: 18,
            ),
        itemCount: songs.length
    );
  }
}
