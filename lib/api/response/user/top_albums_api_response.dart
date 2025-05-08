import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/track/track_info_api_response.dart';

part 'top_albums_api_response.freezed.dart';
part 'top_albums_api_response.g.dart';

@freezed
abstract class TopAlbumsApiResponse with _$TopAlbumsApiResponse {
  const factory TopAlbumsApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'topalbums') required AlbumRootResponse response,
  }) = _TopAlbumsApiResponse;

  factory TopAlbumsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$TopAlbumsApiResponseFromJson(json);
}

@freezed
abstract class AlbumRootResponse with _$AlbumRootResponse {
  const factory AlbumRootResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'album') required List<AlbumResponse> albums,
  }) = _AlbumRootResponse;

  factory AlbumRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumRootResponseFromJson(json);
}

@freezed
abstract class AlbumResponse with _$AlbumResponse {
  const factory AlbumResponse({
    required String name,
    required String playcount,
    required String mbid,
    required String url,
    required TrackInfoArtist artist,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
  }) = _AlbumResponse;

  factory AlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumResponseFromJson(json);
}
