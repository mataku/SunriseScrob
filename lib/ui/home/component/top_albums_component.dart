import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/user/top_album.dart';
import 'package:sunrisescrob/ui/home/component/top_album_component.dart';

class TopAlbumsComponent extends StatelessWidget {
  final List<TopAlbum> albums;
  final bool hasMore;
  final bool isLoading;
  final VoidCallback fetchMore;

  static const _scrollThreshold = 0.75;

  const TopAlbumsComponent({
    super.key,
    required this.albums,
    required this.hasMore,
    required this.isLoading,
    required this.fetchMore,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.only(top: 12),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              childAspectRatio: 0.72,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final album = albums[index];
                return TopAlbumComponent(
                  imageUrl: album.images.imageUrl() ?? '',
                  album: album.name,
                  artist: album.artist.name,
                  playcount: album.playcount,
                  imageKey: "top_album_$index",
                );
              },
              childCount: albums.length,
            ),
          ),
          if (albums.isNotEmpty && isLoading)
            const SliverToBoxAdapter(
              child: CircularProgressIndicator(),
            ),
          if (albums.isNotEmpty && !isLoading)
            const SliverPadding(padding: EdgeInsets.only(top: 24)),
        ],
      ),
      onNotification: (ScrollNotification scrollNotification) {
        if (!hasMore) return false;
        if (scrollNotification is ScrollEndNotification) {
          final scrollProportion = scrollNotification.metrics.pixels /
              scrollNotification.metrics.maxScrollExtent;
          if (hasMore && !isLoading && scrollProportion > _scrollThreshold) {
            fetchMore();
          }
        }
        return false;
      },
    );
  }
}
