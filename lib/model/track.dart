import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/common_name_and_url.dart';
import 'package:sunrisescrob/model/tag.dart';
import 'package:sunrisescrob/model/wiki.dart';

part 'track.freezed.dart';

@freezed
abstract class Track with _$Track {
  const factory Track({
    required String name,
    required String url,
    required String duration,
    required String listeners,
    required String playcount,
    required String userPlayCount,
    TrackAlbum? album,
    required CommonNameAndUrl artist,
    required List<Tag> tags,
    Wiki? wiki,
  }) = _Track;
}

@freezed
abstract class TrackAlbum with _$TrackAlbum {
  const factory TrackAlbum({
    required String artist,
    required String title,
    required String url,
    required List<Artwork> images,
  }) = _TrackAlbum;
}
