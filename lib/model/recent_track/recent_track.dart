import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/common_name.dart';

part 'recent_track.freezed.dart';

@freezed
abstract class RecentTrack with _$RecentTrack {
  const factory RecentTrack({
    required CommonName artist,
    required CommonName album,
    required List<Artwork> images,
    required String name,
    required String url,
  }) = _RecentTrack;
}
