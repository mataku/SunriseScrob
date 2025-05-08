import 'package:freezed_annotation/freezed_annotation.dart';

part 'wiki_response.freezed.dart';
part 'wiki_response.g.dart';

@freezed
abstract class WikiResponse with _$WikiResponse {
  const factory WikiResponse({
    required String published,
    required String summary,
    required String content,
  }) = _WikiResponse;

  factory WikiResponse.fromJson(Map<String, dynamic> json) =>
      _$WikiResponseFromJson(json);
}
