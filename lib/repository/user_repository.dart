import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/api/endpoint/user_top_albums_endpoint.dart';
import 'package:sunrisescrob/api/endpoint/user_top_artists_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/user/top_album.dart';
import 'package:sunrisescrob/model/user/top_artist.dart';
import 'package:sunrisescrob/store/kv_store.dart';

part 'user_repository.g.dart';

// [userRepositoryProvider]
@Riverpod(dependencies: [lastFmApiService, kvStore])
UserRepository userRepository(Ref ref) {
  return _UserRepositoryImpl(
    apiService: ref.read(lastFmApiServiceProvider),
    kvStore: ref.read(kvStoreProvider),
  );
}

abstract class UserRepository {
  Future<Result<List<TopAlbum>>> getTopAlbums(int page);
  Future<Result<List<TopArtist>>> getTopArtists(int page);
}

class _UserRepositoryImpl implements UserRepository {
  final LastFmApiService _lastFmApiService;
  final KVStore _kvStore;

  _UserRepositoryImpl({
    required LastFmApiService apiService,
    required KVStore kvStore,
  })  : _lastFmApiService = apiService,
        _kvStore = kvStore;

  @override
  Future<Result<List<TopAlbum>>> getTopAlbums(int page) async {
    final username = await _kvStore.getStringValue(KVStoreKey.username);
    final endpoint = UserTopAlbumsEndpoint(
      params: {
        'page': page.toString(),
        'user': username,
      },
    );
    try {
      final response = await _lastFmApiService.request(endpoint);
      return Result.success(response.toTopAlbumList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<List<TopArtist>>> getTopArtists(int page) async {
    final username = await _kvStore.getStringValue(KVStoreKey.username);

    final endpoint = UserTopArtistsEndpoint(
      params: {
        'page': page.toString(),
        'user': username,
      },
    );
    try {
      final response = await _lastFmApiService.request(endpoint);
      return Result.success(response.toTopArtistList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
