import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_text_response.freezed.dart';
part 'common_text_response.g.dart';

@freezed
abstract class CommonTextResponse with _$CommonTextResponse {
  factory CommonTextResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: '#text') required String name,
  }) = _CommonTextResponse;

  factory CommonTextResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonTextResponseFromJson(json);
}
