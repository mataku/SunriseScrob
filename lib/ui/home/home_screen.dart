import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/ui/home/scrobble_screen.dart';
import 'package:sunrisescrob/ui/home/top_albums_screen.dart';
import 'package:sunrisescrob/ui/home/top_artists_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    tabs: const [
                      Tab(text: 'Scrobble'),
                      Tab(text: 'Album'),
                      Tab(text: 'Artist'),
                    ],
                    labelColor: theme.colorScheme.onSurface,
                    unselectedLabelColor:
                        theme.colorScheme.onSecondary.withAlpha(128),
                    indicatorColor: theme.colorScheme.onSurface,
                    dividerColor: theme.colorScheme.onSecondary.withAlpha(128),
                  ),
                  centerTitle: false,
                ),
              ];
            },
            body: const TabBarView(
              children: [
                ScrobbleScreen(
                  key: PageStorageKey('scrobble'),
                ),
                TopAlbumsScreen(
                  key: PageStorageKey('top_albums'),
                ),
                TopArtistsScreen(
                  key: PageStorageKey('top_artists'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
