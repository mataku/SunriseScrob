import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/top_tags_response.dart';
import 'package:sunrisescrob/api/response/track/track_info_api_response.dart';
import 'package:sunrisescrob/api/response/wiki_response.dart';

part 'album_info_api_response.freezed.dart';
part 'album_info_api_response.g.dart';

@freezed
abstract class AlbumInfoApiResponse with _$AlbumInfoApiResponse {
  const factory AlbumInfoApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'album') required AlbumInfoApiBody response,
  }) = _AlbumInfoApiResponse;

  factory AlbumInfoApiResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumInfoApiResponseFromJson(json);
}

@freezed
abstract class AlbumInfoApiBody with _$AlbumInfoApiBody {
  const factory AlbumInfoApiBody({
    required String artist,
    TopTagsResponse? tags,
    required String name,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
    required AlbumTrackListApiBody tracks,
    required String listeners,
    required String playcount,
    int? userplaycount,
    required String url,
    WikiResponse? wikiResponse,
  }) = _AlbumInfoApiBody;

  factory AlbumInfoApiBody.fromJson(Map<String, dynamic> json) =>
      _$AlbumInfoApiBodyFromJson(json);
}

@freezed
abstract class AlbumTrackListApiBody with _$AlbumTrackListApiBody {
  const factory AlbumTrackListApiBody({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'track') required List<AlbumTrackApiBody> tracks,
  }) = _AlbumTrackListApiBody;

  factory AlbumTrackListApiBody.fromJson(Map<String, dynamic> json) =>
      _$AlbumTrackListApiBodyFromJson(json);
}

@freezed
abstract class AlbumTrackApiBody with _$AlbumTrackApiBody {
  const factory AlbumTrackApiBody({
    int? duration,
    required String url,
    required String name,
    required TrackInfoArtist artist,
    // ignore: invalid_annotation_target
    @JsonKey(name: '@attr') required RankApiBody rankBody,
  }) = _AlbumTrackApiBody;

  factory AlbumTrackApiBody.fromJson(Map<String, dynamic> json) =>
      _$AlbumTrackApiBodyFromJson(json);
}

@freezed
abstract class RankApiBody with _$RankApiBody {
  const factory RankApiBody({
    required int rank,
  }) = _RankApiBody;

  factory RankApiBody.fromJson(Map<String, dynamic> json) =>
      _$RankApiBodyFromJson(json);
}
