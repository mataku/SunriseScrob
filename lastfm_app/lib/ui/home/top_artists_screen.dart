import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/user/top_artist.dart';
import 'package:state_app/repository/user_repository.dart';
import 'package:state_app/ui/home/component/top_artists_component.dart';

final topArtistsNotifier = ChangeNotifierProvider((ref) {
  final TopArtistsNotifier notifier =
      TopArtistsNotifier(userRepository: ref.read(userRepositoryProvider));
  notifier.fetchData();
  return notifier;
});

class TopArtistsScreen extends ConsumerStatefulWidget {
  const TopArtistsScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TopArtistsPageState();
  }
}

class TopArtistsNotifier extends ChangeNotifier {
  final UserRepository userRepository;

  int _page = 1;

  TopArtistsNotifier({
    required this.userRepository,
  });

  TopArtistsState topArtistsState =
      const TopArtistsState(topArtists: [], hasMore: true, isLoading: false);

  Future fetchData() async {
    if (!topArtistsState.hasMore) return;

    topArtistsState = TopArtistsState(
      topArtists: topArtistsState.topArtists,
      hasMore: topArtistsState.hasMore,
      isLoading: true,
    );

    final result = await userRepository.getTopArtistsSample(_page);

    if (result is Success) {
      List<TopArtist> artists = (result as Success<List<TopArtist>>).data;
      List<TopArtist> currentTopArtists = List.of(topArtistsState.topArtists);
      currentTopArtists.addAll(artists);

      topArtistsState = TopArtistsState(
        topArtists: currentTopArtists,
        hasMore: artists.isNotEmpty,
        isLoading: false,
      );

      if (artists.isNotEmpty) {
        _page++;
      }
    } else {
      topArtistsState = TopArtistsState(
        topArtists: topArtistsState.topArtists,
        hasMore: false,
        isLoading: false,
      );
    }
    notifyListeners();
  }
}

class TopArtistsState {
  final List<TopArtist> topArtists;
  final bool hasMore;
  final bool isLoading;

  const TopArtistsState({
    required this.topArtists,
    required this.hasMore,
    required this.isLoading,
  });
}

class _TopArtistsPageState extends ConsumerState<TopArtistsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final notifier = ref.watch(topArtistsNotifier);
    final topArtistsState = notifier.topArtistsState;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: topArtistsState.topArtists.isEmpty
            ? const SizedBox()
            : TopArtistsComponent(
                artists: topArtistsState.topArtists,
                hasMore: topArtistsState.hasMore,
                isLoading: topArtistsState.isLoading,
                fetchMore: () {
                  notifier.fetchData();
                },
              ),
      ),
    );
  }
}
