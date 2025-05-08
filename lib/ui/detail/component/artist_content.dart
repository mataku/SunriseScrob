import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/artist/artist.dart';
import 'package:sunrisescrob/ui/common/tag_list_component.dart';
import 'package:sunrisescrob/ui/common/wiki_component.dart';
import 'package:sunrisescrob/ui/detail/component/track_metadata.dart';

class ArtistContent extends StatelessWidget {
  final Artist _artist;

  const ArtistContent({
    super.key,
    required Artist artist,
  }) : _artist = artist;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wiki = _artist.wiki;
    // final similarArtists = _artist.similarArtists;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleComponent(title: _artist.name),
        TrackMetadata(
          listeners: _artist.listeners,
          playcount: _artist.playcount,
          userPlaycount: _artist.userplaycount,
        ),
        if (_artist.tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: TagListComponent(
                tags: _artist.tags,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: 15,
            right: 15,
          ),
          child: Divider(
            color: theme.colorScheme.onSecondary.withAlpha(128),
          ),
        ),
        if (wiki != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: WikiComponent(
              title: _artist.name,
              wiki: wiki,
              url: _artist.url,
            ),
          ),
      ],
    );
  }
}

class _TitleComponent extends StatelessWidget {
  final String title;

  const _TitleComponent({
    // ignore: unused_element_parameter
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 8,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
