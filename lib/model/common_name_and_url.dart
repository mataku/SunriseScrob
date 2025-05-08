import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_name_and_url.freezed.dart';

@freezed
abstract class CommonNameAndUrl with _$CommonNameAndUrl {
  const factory CommonNameAndUrl({
    required String name,
    required String url,
  }) = _CommonNameAndUrl;
}
