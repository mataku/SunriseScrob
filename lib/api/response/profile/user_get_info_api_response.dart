import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';

part 'user_get_info_api_response.freezed.dart';
part 'user_get_info_api_response.g.dart';

@freezed
abstract class UserGetInfoApiResponse with _$UserGetInfoApiResponse {
  const factory UserGetInfoApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user') required UserGetInfoResponse response,
  }) = _UserGetInfoApiResponse;

  factory UserGetInfoApiResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGetInfoApiResponseFromJson(json);
}

@freezed
abstract class UserGetInfoResponse with _$UserGetInfoResponse {
  const factory UserGetInfoResponse({
    required String name,
    required String subscriber,
    required String playcount,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artist_count') required String artistCount,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'track_count') required String trackCount,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'album_count') required String albumCount,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
    required String url,
  }) = _UserGetInfoResponse;

  factory UserGetInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGetInfoResponseFromJson(json);
}
