import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_app/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  String? cover;
  num? duration;
  Timestamp? releaseTime;

  SongModel(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseTime,
      required this.cover});

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseTime = data['releasetime'];
    cover = data['cover'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
        title: title!,
        artist: artist!,
        duration: duration!,
        releaseTime: releaseTime!,
        cover: cover!);
  }
}
