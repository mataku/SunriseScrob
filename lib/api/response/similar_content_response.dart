import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';

part 'similar_content_response.freezed.dart';
part 'similar_content_response.g.dart';

@freezed
abstract class SimilarContentResponse with _$SimilarContentResponse {
  const factory SimilarContentResponse({
    required String name,
    required String url,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
  }) = _SimilarContentResponse;

  factory SimilarContentResponse.fromJson(Map<String, dynamic> json) =>
      _$SimilarContentResponseFromJson(json);
}
