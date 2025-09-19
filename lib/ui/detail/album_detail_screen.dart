import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:sunrisescrob/model/album/album.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/album_repository.dart';
import 'package:sunrisescrob/ui/common/artwork_component.dart';
import 'package:sunrisescrob/ui/detail/component/album_content.dart';

class AlbumDetailScreen extends ConsumerStatefulWidget {
  final String artist;
  final String album;
  final String imageKey;
  final String imageUrl;

  const AlbumDetailScreen({
    super.key,
    required this.artist,
    required this.album,
    required this.imageKey,
    required this.imageUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AlbumDetailState();
  }
}

class _AlbumDetailState extends ConsumerState<AlbumDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    ref.read(albumNotifierProvider).fetchAlbum(
          artist: widget.artist,
          album: widget.album,
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
    final notifier = ref.watch(albumNotifierProvider);
    final album = notifier.albumDetail;
    final theme = Theme.of(context);
    EdgeInsets padding = MediaQuery.paddingOf(context);
    if (album != null) {
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
                if (album != null)
                  FadeTransition(
                    opacity: _animation,
                    child: AlbumContent(
                      album: album,
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

final albumNotifierProvider = ChangeNotifierProvider(
  (ref) => AlbumNotifier(
    albumRepository: ref.read(albumRepositoryProvider),
  ),
);

class AlbumNotifier extends ChangeNotifier {
  final AlbumRepository _albumRepository;

  AlbumNotifier({
    required AlbumRepository albumRepository,
  }) : _albumRepository = albumRepository;

  Album? albumDetail;

  Future fetchAlbum({
    required String artist,
    required String album,
  }) async {
    Result<Album> result = await _albumRepository.getAlbumInfo(
      artist: artist,
      album: album,
    );
    if (result is Success) {
      albumDetail = result.getOrNull()!;
      notifyListeners();
    }
  }
}
