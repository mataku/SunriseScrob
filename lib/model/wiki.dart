import 'package:freezed_annotation/freezed_annotation.dart';

part 'wiki.freezed.dart';

@freezed
abstract class Wiki with _$Wiki {
  const factory Wiki({
    required String published,
    required String summary,
    required String content,
  }) = _Wiki;
}
