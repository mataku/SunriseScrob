import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'artwork.freezed.dart';

@freezed
abstract class Artwork with _$Artwork {
  const factory Artwork({
    required String size,
    required String url,
  }) = _Artwork;
}

extension ArtworkListExt on List<Artwork> {
  String? imageUrl() {
    final extraLargeImage =
        firstWhereOrNull((track) => track.size == "extralarge");
    if (extraLargeImage != null) {
      return extraLargeImage.url;
    }
    final largeImage = firstWhereOrNull((track) => track.size == "large");
    if (largeImage != null) {
      return largeImage.url;
    }

    return null;
  }
}
