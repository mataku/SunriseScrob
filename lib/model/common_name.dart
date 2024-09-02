import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_name.freezed.dart';

@freezed
class CommonName with _$CommonName {
  const factory CommonName({required String name}) = _CommonName;
}
