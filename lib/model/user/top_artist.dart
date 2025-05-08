import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';

part 'top_artist.freezed.dart';

@freezed
abstract class TopArtist with _$TopArtist {
  const factory TopArtist({
    required String name,
    required String url,
    required String playcount,
    required List<Artwork> images,
  }) = _TopArtist;
}
