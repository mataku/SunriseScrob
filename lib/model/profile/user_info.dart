import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';

part 'user_info.freezed.dart';

@freezed
abstract class UserInfo with _$UserInfo {
  const factory UserInfo({
    required String name,
    required bool isSubscriber,
    required String playcount,
    required String artistCount,
    required String trackCount,
    required String albumCount,
    required List<Artwork> images,
    required String url,
  }) = _UserInfo;
}
