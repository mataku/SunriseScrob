import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_response.freezed.dart';
part 'image_response.g.dart';

// {
//   "size": "small",
//   "#text": "https://lastfm.freetls.fastly.net/i/u/34s/e8926a5d5246b73aca21d7396a894a93.jpg"
// },

@freezed
abstract class ImageResponse with _$ImageResponse {
  factory ImageResponse(
    // ignore: invalid_annotation_target
    @JsonKey(name: '#text') String url,
    String size,
  ) = _ImageResponse;

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);
}
