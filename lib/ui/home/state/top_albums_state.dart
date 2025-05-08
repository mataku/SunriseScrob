import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/user/top_album.dart';

part 'top_albums_state.freezed.dart';

@freezed
abstract class TopAlbumsState with _$TopAlbumsState {
  const factory TopAlbumsState({
    required List<TopAlbum> topAlbums,
    required bool hasMore,
    required bool isLoading,
  }) = _TopAlbumsState;
}
