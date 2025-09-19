import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/api/endpoint/artist_get_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/artist/artist.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/store/kv_store.dart';

part 'artist_repository.g.dart';

@Riverpod(dependencies: [lastFmApiService, kvStore])
ArtistRepository artistRepository(Ref ref) {
  return _ArtistRepositoryImpl(
    apiService: ref.read(lastFmApiServiceProvider),
    kvStore: ref.read(kvStoreProvider),
  );
}

abstract class ArtistRepository {
  Future<Result<Artist>> getArtistInfo({
    required String artist,
  });
}

class _ArtistRepositoryImpl implements ArtistRepository {
  final LastFmApiService _apiService;
  final KVStore _kvStore;

  _ArtistRepositoryImpl({
    required LastFmApiService apiService,
    required KVStore kvStore,
  })  : _apiService = apiService,
        _kvStore = kvStore;

  @override
  Future<Result<Artist>> getArtistInfo({
    required String artist,
  }) async {
    final username = await _kvStore.getStringValue(KVStoreKey.username);
    final endpoint = ArtistGetInfoEndpoint(
      params: {
        'artist': artist,
        'user': username,
      },
    );
    try {
      final result = await _apiService.request(endpoint);
      return Result.success(result.toArtist());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
