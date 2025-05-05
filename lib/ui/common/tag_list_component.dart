import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/tag.dart';

class TagListComponent extends StatelessWidget {
  final List<Tag> tags;

  const TagListComponent({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16, right: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final tag = tags[index];
        return _TagComponent(tag: tag);
      },
      itemCount: tags.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 12,
        );
      },
    );
  }
}

class _TagComponent extends StatelessWidget {
  final Tag tag;

  const _TagComponent({
    // ignore: unused_element_parameter
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      label: Text(
        tag.name,
        style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      side: BorderSide(color: theme.colorScheme.onPrimaryContainer),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: 0),
    );
  }
}
