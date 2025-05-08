import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';

part 'similar_content.freezed.dart';

@freezed
abstract class SimilarContent with _$SimilarContent {
  const factory SimilarContent({
    required String name,
    required String url,
    required List<Artwork> images,
  }) = _SimilarContent;
}
