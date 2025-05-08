import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';

part 'top_artists_api_response.freezed.dart';
part 'top_artists_api_response.g.dart';

@freezed
abstract class TopArtistsApiResponse with _$TopArtistsApiResponse {
  const factory TopArtistsApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'topartists') required TopArtistsResponse response,
  }) = _TopArtistsApiResponse;

  factory TopArtistsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$TopArtistsApiResponseFromJson(json);
}

@freezed
abstract class TopArtistsResponse with _$TopArtistsResponse {
  const factory TopArtistsResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artist') required List<ArtistResponse> artists,
  }) = _TopArtistsResponse;

  factory TopArtistsResponse.fromJson(Map<String, dynamic> json) =>
      _$TopArtistsResponseFromJson(json);
}

@freezed
abstract class ArtistResponse with _$ArtistResponse {
  const factory ArtistResponse({
    required String name,
    required String url,
    required String playcount,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
  }) = _ArtistResponse;

  factory ArtistResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistResponseFromJson(json);
}
