import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:sunrisescrob/model/artist/artist.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/artist_repository.dart';
import 'package:sunrisescrob/ui/common/artwork_component.dart';
import 'package:sunrisescrob/ui/detail/component/artist_content.dart';

class ArtistDetailScreen extends ConsumerStatefulWidget {
  final String artist;
  final String imageKey;
  final String imageUrl;

  const ArtistDetailScreen({
    super.key,
    required this.artist,
    required this.imageKey,
    required this.imageUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ArtistDetailState();
  }
}

class _ArtistDetailState extends ConsumerState<ArtistDetailScreen>
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
    ref.read(artistNotifierProvider).fetchArtist(
          widget.artist,
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
    final notifier = ref.watch(artistNotifierProvider);
    final artist = notifier.artistDetail;
    final theme = Theme.of(context);
    EdgeInsets padding = MediaQuery.paddingOf(context);
    if (artist != null) {
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
                if (artist != null)
                  FadeTransition(
                    opacity: _animation,
                    child: ArtistContent(
                      artist: artist,
                    ),
                  ),
                const Padding(padding: EdgeInsets.only(top: 24)),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 60,
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

final artistNotifierProvider = ChangeNotifierProvider.autoDispose((ref) {
  return ArtistNotifier(artistRepository: ref.read(artistRepositoryProvider));
});

class ArtistNotifier extends ChangeNotifier {
  final ArtistRepository _artistRepository;

  ArtistNotifier({
    required ArtistRepository artistRepository,
  }) : _artistRepository = artistRepository;

  Artist? artistDetail;

  Future fetchArtist(
    String artist,
  ) async {
    Result<Artist> result =
        await _artistRepository.getArtistInfo(artist: artist);
    if (result is Success) {
      artistDetail = result.getOrNull()!;
      notifyListeners();
    }
  }
}
