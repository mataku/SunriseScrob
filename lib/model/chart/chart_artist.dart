import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';

part 'chart_artist.freezed.dart';

@freezed
abstract class ChartArtist with _$ChartArtist {
  const factory ChartArtist({
    required String name,
    required String playCount,
    required String listeners,
    required String url,
    required List<Artwork> images,
  }) = _ChartArtist;
}
