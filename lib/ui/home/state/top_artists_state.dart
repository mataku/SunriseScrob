import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_app/model/user/top_artist.dart';

part 'top_artists_state.freezed.dart';

@freezed
class TopArtistsState with _$TopArtistsState {
  const factory TopArtistsState({
    required List<TopArtist> topArtists,
    required bool hasMore,
    required bool isLoading,
  }) = _TopArtistsState;
}
