import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/similar_content_response.dart';
import 'package:sunrisescrob/api/response/top_tags_response.dart';
import 'package:sunrisescrob/api/response/wiki_response.dart';

part 'artist_info_api_response.freezed.dart';
part 'artist_info_api_response.g.dart';

@freezed
abstract class ArtistInfoApiResponse with _$ArtistInfoApiResponse {
  const factory ArtistInfoApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artist') required ArtistInfoBody body,
  }) = _ArtistInfoApiResponse;

  factory ArtistInfoApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistInfoApiResponseFromJson(json);
}

@freezed
abstract class ArtistInfoBody with _$ArtistInfoBody {
  const factory ArtistInfoBody({
    required String name,
    required String url,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
    required StatsBody stats,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'similar') SimilarArtistsBody? similarArtists,
    required TopTagsResponse tags,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'bio') WikiResponse? wiki,
  }) = _ArtistInfoBody;

  factory ArtistInfoBody.fromJson(Map<String, dynamic> json) =>
      _$ArtistInfoBodyFromJson(json);
}

@freezed
abstract class SimilarArtistsBody with _$SimilarArtistsBody {
  const factory SimilarArtistsBody({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artist') required List<SimilarContentResponse> artists,
  }) = _SimilarArtistsBody;

  factory SimilarArtistsBody.fromJson(Map<String, dynamic> json) =>
      _$SimilarArtistsBodyFromJson(json);
}

@freezed
abstract class StatsBody with _$StatsBody {
  const factory StatsBody({
    required String listeners,
    required String playcount,
    String? userplaycount,
  }) = _StatsBody;

  factory StatsBody.fromJson(Map<String, dynamic> json) =>
      _$StatsBodyFromJson(json);
}
