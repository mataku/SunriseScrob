import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';

part 'chart_track.freezed.dart';

@freezed
abstract class ChartTrack with _$ChartTrack {
  const factory ChartTrack({
    required String name,
    required String playCount,
    required String listeners,
    required String url,
    required ChartTrackArtist artist,
    required List<Artwork> images,
  }) = _ChartTrack;
}

@freezed
abstract class ChartTrackArtist with _$ChartTrackArtist {
  const factory ChartTrackArtist({
    required String name,
    required String url,
  }) = _ChartTrackArtist;
}
