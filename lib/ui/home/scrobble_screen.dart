import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/recent_track/recent_track.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/recent_tracks_repository.dart';
import 'package:sunrisescrob/router/router.dart';
import 'package:sunrisescrob/ui/home/component/recent_track_component.dart';
import 'package:sunrisescrob/ui/home/state/scrobble_state.dart';

final scrobbleNotifierProvider = ChangeNotifierProvider((ref) {
  final ScrobbleNotifier notifier = ScrobbleNotifier(
    recentTracksRepository: ref.read(recentTracksRepositoryProvider),
  );
  notifier.fetchData();
  return notifier;
});

class ScrobbleScreen extends ConsumerWidget {
  final _scrollThreshold = 0.8;

  const ScrobbleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(scrobbleNotifierProvider);
    final uiState = notifier.uiState;
    return NotificationListener(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final track = uiState.recentTracks[index];
              return RecentTrackComponent(
                recentTrack: track,
                imageKey: "scrobble_$index",
                onTap: () {
                  TrackDetailRoute(
                    artist: track.artist.name,
                    track: track.name,
                    imageKey: "scrobble_$index",
                    imageUrl: track.images.imageUrl() ?? '',
                  ).go(context);
                },
              );
            },
            itemCount: uiState.recentTracks.length,
          ),
        ),
      ),
      onNotification: (ScrollNotification scrollNotification) {
        if (!uiState.hasMore || uiState.isLoading) return false;
        if (scrollNotification is ScrollEndNotification) {
          final scrollPosition = scrollNotification.metrics.pixels /
              scrollNotification.metrics.maxScrollExtent;
          if (scrollPosition > _scrollThreshold) {
            notifier.fetchData();
          }
        }
        return false;
      },
    );
  }
}

class ScrobbleNotifier extends ChangeNotifier {
  final RecentTracksRepository recentTracksRepository;

  int _page = 1;

  ScrobbleNotifier({required this.recentTracksRepository});

  ScrobbleState uiState = ScrobbleState(
    recentTracks: List.empty(),
    hasMore: true,
    isLoading: false,
  );

  List<RecentTrack> tracks = List.empty();

  Future fetchData() async {
    if (uiState.isLoading || !uiState.hasMore) return;

    uiState = uiState.copyWith(isLoading: true);
    final result = await recentTracksRepository.getRecentTracks(_page);
    if (result is Success) {
      tracks = result.getOrNull()!;
      var currentTracks = List.of(uiState.recentTracks);
      currentTracks.addAll(tracks);
      uiState = uiState.copyWith(
        recentTracks: currentTracks,
        hasMore: tracks.isNotEmpty,
        isLoading: false,
      );
      _page++;
    } else {
      uiState = uiState.copyWith(
        hasMore: false,
        isLoading: false,
      );
    }
    notifyListeners();
  }
}
