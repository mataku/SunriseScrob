import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/api/endpoint/user_get_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/profile/user_info.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/store/kv_store.dart';

part 'profile_repository.g.dart';

@Riverpod(dependencies: [lastFmApiService, kvStore])
ProfileRepository profileRepository(Ref ref) {
  return _ProfileRepositoryImpl(
    apiService: ref.read(lastFmApiServiceProvider),
    kvStore: ref.read(kvStoreProvider),
  );
}

abstract class ProfileRepository {
  Future<Result<UserInfo>> getUserInfo();
}

class _ProfileRepositoryImpl implements ProfileRepository {
  final KVStore _kvStore;
  final LastFmApiService _apiService;

  _ProfileRepositoryImpl({
    required LastFmApiService apiService,
    required KVStore kvStore,
  })  : _apiService = apiService,
        _kvStore = kvStore;

  @override
  Future<Result<UserInfo>> getUserInfo() async {
    final username = await _kvStore.getStringValue(KVStoreKey.username);
    final endpoint = UserGetInfoEndpoint(
      params: {'user': username},
    );
    try {
      final response = await _apiService.request(endpoint);
      return Result.success(response.response.toUserInfo());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
