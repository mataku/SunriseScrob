import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/track.dart';
import 'package:sunrisescrob/ui/common/artwork_component.dart';

class TrackAlbumComponent extends StatelessWidget {
  final TrackAlbum album;

  const TrackAlbumComponent({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Album',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Row(
          children: [
            const ArtworkComponent(
              imageUrl: null,
              size: 96,
            ),
            const Padding(padding: EdgeInsets.only(left: 16)),
            Expanded(
              child: _AlbumTitleComponent(
                title: album.title,
                artist: album.artist,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AlbumTitleComponent extends StatelessWidget {
  final String title;
  final String artist;

  const _AlbumTitleComponent({
    // ignore: unused_element_parameter
    super.key,
    required this.title,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          artist,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
