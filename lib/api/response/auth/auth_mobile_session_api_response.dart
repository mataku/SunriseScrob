import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_mobile_session_api_response.freezed.dart';
part 'auth_mobile_session_api_response.g.dart';

@freezed
abstract class AuthMobileSessionApiResponse
    with _$AuthMobileSessionApiResponse {
  const factory AuthMobileSessionApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'session') required MobileSessionBody sessionBody,
  }) = _AuthMobileSessionApiResponse;

  factory AuthMobileSessionApiResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthMobileSessionApiResponseFromJson(json);
}

@freezed
abstract class MobileSessionBody with _$MobileSessionBody {
  const factory MobileSessionBody({
    required String name,
    required String key,
  }) = _MobileSessionBody;

  factory MobileSessionBody.fromJson(Map<String, dynamic> json) =>
      _$MobileSessionBodyFromJson(json);
}
