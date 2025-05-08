import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/common_name_and_url.dart';

part 'top_album.freezed.dart';

@freezed
abstract class TopAlbum with _$TopAlbum {
  const factory TopAlbum({
    required String name,
    required String playcount,
    required String mbid,
    required String url,
    required CommonNameAndUrl artist,
    required List<Artwork> images,
  }) = _TopAlbum;
}
