import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging_attr.freezed.dart';

@freezed
abstract class PagingAttr with _$PagingAttr {
  const factory PagingAttr({
    required String totalPages,
    required String total,
  }) = _PagingAttr;
}
