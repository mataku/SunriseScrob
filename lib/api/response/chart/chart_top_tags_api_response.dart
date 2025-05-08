import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/paging_attr_body_response.dart';

part 'chart_top_tags_api_response.freezed.dart';
part 'chart_top_tags_api_response.g.dart';

@freezed
abstract class ChartTopTagsApiResponse with _$ChartTopTagsApiResponse {
  const factory ChartTopTagsApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'tags') required ChartTopTagsApiBody body,
  }) = _ChartTopTagsApiResponse;

  factory ChartTopTagsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTagsApiResponseFromJson(json);
}

@freezed
abstract class ChartTopTagsApiBody with _$ChartTopTagsApiBody {
  const factory ChartTopTagsApiBody({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'tag') required List<ChartTopTagResponse> tags,
    // ignore: invalid_annotation_target
    @JsonKey(name: '@attr')
    required PagingAttrBodyResponse pagingAttrBodyResponse,
  }) = _ChartTopTagsApiBody;

  factory ChartTopTagsApiBody.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTagsApiBodyFromJson(json);
}

@freezed
abstract class ChartTopTagResponse with _$ChartTopTagResponse {
  const factory ChartTopTagResponse({
    required String name,
    required String url,
  }) = _ChartTopTagResponse;

  factory ChartTopTagResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTagResponseFromJson(json);
}
