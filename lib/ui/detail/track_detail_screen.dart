import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/track.dart';
import 'package:sunrisescrob/repository/track_repository.dart';
import 'package:sunrisescrob/ui/common/artwork_component.dart';
import 'package:sunrisescrob/ui/detail/component/track_content_component.dart';

final trackNotifierProvider = ChangeNotifierProvider.autoDispose((ref) {
  final trackNotifier =
      TrackNotifier(trackRepository: ref.read(trackRepositoryProvider));
  return trackNotifier;
});

class TrackDetailScreen extends ConsumerStatefulWidget {
  final String artist;
  final String track;
  final String imageKey;
  final String imageUrl;

  const TrackDetailScreen({
    super.key,
    required this.artist,
    required this.track,
    required this.imageKey,
    required this.imageUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackDetailState();
}

class _TrackDetailState extends ConsumerState<TrackDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    ref.read(trackNotifierProvider).fetchTrack(
          artist: widget.artist,
          track: widget.track,
        );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(trackNotifierProvider);
    final track = notifier.trackDetail;
    final theme = Theme.of(context);
    EdgeInsets padding = MediaQuery.paddingOf(context);

    if (track != null) {
      _controller.forward();
    }
    return SafeArea(
      top: false,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: widget.imageKey,
                  child: ArtworkSquareComponent(
                    imageUrl: widget.imageUrl,
                    size: double.infinity,
                  ),
                ),
                if (track != null)
                  FadeTransition(
                    opacity: _animation,
                    child: TrackContentComponent(track: track),
                  ),
                const Padding(padding: EdgeInsets.only(top: 24)),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(128),
                      Colors.white.withAlpha(2),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: padding.top,
                  left: 16,
                ),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.surface.withAlpha(192),
                  ),
                  child: GestureDetector(
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: theme.colorScheme.onSurface,
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TrackNotifier extends ChangeNotifier {
  final TrackRepository trackRepository;

  TrackNotifier({required this.trackRepository});

  Track? trackDetail;

  Future fetchTrack({
    required String artist,
    required String track,
  }) async {
    Result<Track> result = await trackRepository.getTrack(
      track: track,
      artist: artist,
    );
    if (result is Success) {
      trackDetail = result.getOrNull()!;
      notifyListeners();
    }
  }
}
