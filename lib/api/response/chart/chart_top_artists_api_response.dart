import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/paging_attr_body_response.dart';

part 'chart_top_artists_api_response.freezed.dart';
part 'chart_top_artists_api_response.g.dart';

@freezed
abstract class ChartTopArtistsApiResponse with _$ChartTopArtistsApiResponse {
  const factory ChartTopArtistsApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artists') required ChartTopArtistsApiBody body,
  }) = _ChartTopArtistsApiResponse;

  factory ChartTopArtistsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTopArtistsApiResponseFromJson(json);
}

@freezed
abstract class ChartTopArtistsApiBody with _$ChartTopArtistsApiBody {
  const factory ChartTopArtistsApiBody({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artist') required List<ChartArtistResponse> artists,
    // ignore: invalid_annotation_target
    @JsonKey(name: '@attr')
    required PagingAttrBodyResponse pagingAttrBodyResponse,
  }) = _ChartTopArtistsApiBody;

  factory ChartTopArtistsApiBody.fromJson(Map<String, dynamic> json) =>
      _$ChartTopArtistsApiBodyFromJson(json);
}

@freezed
abstract class ChartArtistResponse with _$ChartArtistResponse {
  const factory ChartArtistResponse({
    required String name,
    required String url,
    required String playcount,
    required String listeners,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
  }) = _ChartArtistResponse;

  factory ChartArtistResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartArtistResponseFromJson(json);
}
