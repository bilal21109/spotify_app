import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/helpers/is_dark_mode.dart';
import 'package:spotify_app/core/configs/constants/app_urls.dart';
import 'package:spotify_app/domain/entities/song/song.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_app/presentation/song_player/pages/song_player.dart';

import '../../../core/theme/app_colors.dart';
import '../bloc/news_songs_cubit.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
          height: 200,
          child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
              builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
            if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            }
            return Container();
          })),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String cover =
              "${AppURLs.fireStorage}${songs[index].artist} - ${songs[index].title!.trim()}.jpg?${AppURLs.mediaAlt}&${AppURLs.token}";
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SongPlayerPage(
                        songEntity: songs[index],
                      )));
            },
            child: SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(songs[index].cover))),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.isDarkMode
                                  ? AppColors.darkGrey
                                  : Colors.white),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: context.isDarkMode
                                ? Color(0xff959595)
                                : Color(0xff555555),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    songs[index].title.toString(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    songs[index].artist.toString(),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              width: 15,
            ),
        itemCount: songs.length);
  }
}
