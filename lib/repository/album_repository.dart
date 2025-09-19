import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/api/endpoint/album_get_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/album/album.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/store/kv_store.dart';

part 'album_repository.g.dart';

// [albumRepositoryProvider]
@Riverpod(dependencies: [lastFmApiService, kvStore])
AlbumRepository albumRepository(Ref ref) {
  return _AlbumRepositoryImpl(
    apiService: ref.read(lastFmApiServiceProvider),
    kvStore: ref.read(kvStoreProvider),
  );
}

abstract class AlbumRepository {
  Future<Result<Album>> getAlbumInfo({
    required String artist,
    required String album,
  });
}

class _AlbumRepositoryImpl implements AlbumRepository {
  final LastFmApiService _apiService;
  final KVStore _kvStore;

  _AlbumRepositoryImpl({
    required LastFmApiService apiService,
    required KVStore kvStore,
  })  : _apiService = apiService,
        _kvStore = kvStore;

  @override
  Future<Result<Album>> getAlbumInfo({
    required String artist,
    required String album,
  }) async {
    final username = await _kvStore.getStringValue(KVStoreKey.username);
    final endpoint = AlbumGetInfoEndpoint(
      params: {
        'album': album,
        'artist': artist,
        'user': username,
      },
    );
    try {
      final result = await _apiService.request(endpoint);
      return Result.success(result.toAlbum());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
