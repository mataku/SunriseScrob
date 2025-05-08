import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/top_tags_response.dart';
import 'package:sunrisescrob/api/response/wiki_response.dart';

part 'track_info_api_response.freezed.dart';
part 'track_info_api_response.g.dart';

@freezed
abstract class TrackInfoApiResponse with _$TrackInfoApiResponse {
  const factory TrackInfoApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'track') required TrackInfoResponse response,
  }) = _TrackInfoApiResponse;

  factory TrackInfoApiResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackInfoApiResponseFromJson(json);
}

@freezed
abstract class TrackInfoResponse with _$TrackInfoResponse {
  const factory TrackInfoResponse({
    required String name,
    required String url,
    required String duration,
    required String listeners,
    required String playcount,
    required TrackInfoArtist artist,
    TrackAlbumResponse? album,
    WikiResponse? wiki,
    String? userplaycount,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'toptags') required TopTagsResponse tags,
  }) = _TrackInfoResponse;

  factory TrackInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackInfoResponseFromJson(json);
}

@freezed
abstract class TrackAlbumResponse with _$TrackAlbumResponse {
  const factory TrackAlbumResponse({
    required String artist,
    required String title,
    required String url,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
  }) = _TrackAlbumResponse;

  factory TrackAlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackAlbumResponseFromJson(json);
}

@freezed
abstract class TrackInfoArtist with _$TrackInfoArtist {
  const factory TrackInfoArtist({
    required String name,
    required String url,
  }) = _TrackInfoArtist;

  factory TrackInfoArtist.fromJson(Map<String, dynamic> json) =>
      _$TrackInfoArtistFromJson(json);
}
