import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sunrisescrob/model/chart/chart_artist.dart';
import 'package:sunrisescrob/model/chart/chart_track.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/tag.dart';
import 'package:sunrisescrob/repository/chart_repository.dart';
import 'package:sunrisescrob/ui/discover/component/chart_artists_component.dart';
import 'package:sunrisescrob/ui/discover/component/chart_tags_component.dart';
import 'package:sunrisescrob/ui/discover/component/chart_tracks_component.dart';

final discoverNotifierProvider = ChangeNotifierProvider.autoDispose((ref) {
  final DiscoverNotifier notifier =
      DiscoverNotifier(chartRepository: ref.read(chartRepositoryProvider));
  notifier.fetchCharts();
  return notifier;
});

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(discoverNotifierProvider);
    final tracks = notifier.tracks;
    final artists = notifier.artists;
    final tags = notifier.tags;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discover',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          surfaceTintColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(12),
            child: Divider(
              color: theme.colorScheme.onSecondary.withAlpha(128),
            ),
          ),
          centerTitle: false,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ChartTracksComponent(tracks: tracks),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 8, bottom: 8)),
            SliverToBoxAdapter(
              child: ChartArtistsComponent(artists: artists),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 8, bottom: 8)),
            SliverToBoxAdapter(
              child: ChartTagsComponent(tags: tags),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscoverNotifier extends ChangeNotifier {
  final ChartRepository chartRepository;

  DiscoverNotifier({required this.chartRepository});

  List<ChartTrack> tracks = List.empty();
  List<ChartArtist> artists = List.empty();
  List<Tag> tags = List.empty();

  Future fetchCharts() async {
    // TODO: request in parallel
    final trackResult = await chartRepository.getChartTracks(1);
    if (trackResult is Success) {
      tracks = trackResult.getOrNull()!;
    }

    final artistResult = await chartRepository.getChartArtists(1);
    if (artistResult is Success) {
      artists = artistResult.getOrNull()!;
    }

    final tagResult = await chartRepository.getChartTags(1);
    if (tagResult is Success) {
      tags = tagResult.getOrNull()!;
    }

    notifyListeners();
  }
}
