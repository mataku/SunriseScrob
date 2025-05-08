import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/similar_content.dart';
import 'package:sunrisescrob/model/tag.dart';
import 'package:sunrisescrob/model/wiki.dart';

part 'artist.freezed.dart';

@freezed
abstract class Artist with _$Artist {
  const factory Artist({
    required String name,
    required String url,
    required List<Artwork> images,
    Wiki? wiki,
    required List<SimilarContent> similarArtists,
    required List<Tag> tags,
    required String listeners,
    required String playcount,
    required String userplaycount,
  }) = _Artist;
}
