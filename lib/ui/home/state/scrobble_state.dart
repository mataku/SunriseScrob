import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/recent_track/recent_track.dart';

part 'scrobble_state.freezed.dart';

@freezed
abstract class ScrobbleState with _$ScrobbleState {
  const factory ScrobbleState({
    required List<RecentTrack> recentTracks,
    required bool hasMore,
    required bool isLoading,
  }) = _ScrobbleState;
}
