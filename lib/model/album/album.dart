import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/common_name_and_url.dart';
import 'package:sunrisescrob/model/tag.dart';
import 'package:sunrisescrob/model/wiki.dart';

part 'album.freezed.dart';

@freezed
abstract class Album with _$Album {
  const factory Album({
    required String artist,
    required String name,
    required List<Tag> tags,
    required List<Artwork> images,
    required List<AlbumTrack> tracks,
    required String listeners,
    required String playcount,
    required int userplaycount,
    required String url,
    Wiki? wiki,
  }) = _Album;
}

@freezed
abstract class AlbumTrack with _$AlbumTrack {
  const factory AlbumTrack({
    int? duration,
    required String url,
    required String name,
    required int position,
    required CommonNameAndUrl artist,
  }) = _AlbumTrack;
}
