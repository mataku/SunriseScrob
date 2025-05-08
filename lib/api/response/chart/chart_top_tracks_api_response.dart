import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/paging_attr_body_response.dart';

part 'chart_top_tracks_api_response.freezed.dart';
part 'chart_top_tracks_api_response.g.dart';

@freezed
abstract class ChartTopTracksApiResponse with _$ChartTopTracksApiResponse {
  const factory ChartTopTracksApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'tracks') required ChartTopTracksApiBody body,
  }) = _ChartTopTracksApiResponse;

  factory ChartTopTracksApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTracksApiResponseFromJson(json);
}

@freezed
abstract class ChartTopTracksApiBody with _$ChartTopTracksApiBody {
  const factory ChartTopTracksApiBody({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'track') required List<ChartTrackResponse> tracks,
    // ignore: invalid_annotation_target
    @JsonKey(name: '@attr')
    required PagingAttrBodyResponse pagingAttrBodyResponse,
  }) = _ChartTopTracksApiBody;

  factory ChartTopTracksApiBody.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTracksApiBodyFromJson(json);
}

@freezed
abstract class ChartTrackResponse with _$ChartTrackResponse {
  const factory ChartTrackResponse({
    required String name,
    required String url,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'playcount') required String playCount,
    required String listeners,
    required ChartTrackArtistResponse artist,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
  }) = _ChartTrackResponse;

  factory ChartTrackResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTrackResponseFromJson(json);
}

@freezed
abstract class ChartTrackArtistResponse with _$ChartTrackArtistResponse {
  const factory ChartTrackArtistResponse({
    required String name,
    required String url,
  }) = _ChartTrackArtistResponse;

  factory ChartTrackArtistResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTrackArtistResponseFromJson(json);
}
