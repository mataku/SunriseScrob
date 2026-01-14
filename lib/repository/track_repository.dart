import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/api/endpoint/track_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/track.dart';
import 'package:sunrisescrob/store/kv_store.dart';

part 'track_repository.g.dart';

@Riverpod(dependencies: [lastFmApiService, kvStore])
TrackRepository trackRepository(Ref ref) {
  return _TrackRepositoryImpl(
    lastFmApiService: ref.read(lastFmApiServiceProvider),
    kvStore: ref.read(kvStoreProvider),
  );
}

abstract class TrackRepository {
  Future<Result<Track>> getTrack({
    required String track,
    required String artist,
  });
}

class _TrackRepositoryImpl implements TrackRepository {
  final LastFmApiService _lastFmApiService;
  final KVStore _kvStore;

  _TrackRepositoryImpl({
    required LastFmApiService lastFmApiService,
    required KVStore kvStore,
  })  : _lastFmApiService = lastFmApiService,
        _kvStore = kvStore;

  @override
  Future<Result<Track>> getTrack({
    required String track,
    required String artist,
  }) async {
    final username = await _kvStore.getStringValue(KVStoreKey.username);
    final endpoint = TrackInfoEndpoint(
      params: {
        'artist': artist,
        'track': track,
        'username': username,
      },
    );
    try {
      final response = await _lastFmApiService.request(endpoint);
      return Result.success(response.toTrack());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
