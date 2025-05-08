import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging_attr_body_response.freezed.dart';
part 'paging_attr_body_response.g.dart';

@freezed
abstract class PagingAttrBodyResponse with _$PagingAttrBodyResponse {
  const factory PagingAttrBodyResponse({
    required String page,
    required String perPage,
    required String totalPages,
    required String total,
  }) = _PagingAttrBodyResponse;

  factory PagingAttrBodyResponse.fromJson(Map<String, dynamic> json) =>
      _$PagingAttrBodyResponseFromJson(json);
}
