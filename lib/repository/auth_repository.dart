import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/api/endpoint/auth_get_mobile_session_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/lastfm_api_signature.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/store/kv_store.dart';
import 'package:sunrisescrob/store/session_store.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(lastFmApiServiceProvider),
    ref.read(sessionChangeNotifierProvider),
    ref.read(kvStoreProvider),
  ),
);

abstract class AuthRepository {
  Future<Result<String>> authorize({
    required String username,
    required String password,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final LastFmApiService _apiService;
  // TODO: reconsider
  final SessionChangeNotifier _notifier;

  final KVStore _kvStore;

  AuthRepositoryImpl(
    this._apiService,
    this._notifier,
    this._kvStore,
  );

  @override
  Future<Result<String>> authorize(
      {required String username, required String password}) async {
    Map<String, String> params = {
      'username': username,
      'password': password,
      'method': 'auth.getMobileSession',
    };
    final apiSignature = LastfmApiSignature.generate(params);
    params['api_sig'] = apiSignature;

    final endpoint = AuthGetMobileSessionEndpoint(
      params: params,
    );
    try {
      final result = await _apiService.request(endpoint);
      await _kvStore.setStringValue(
          KVStoreKey.username, result.sessionBody.name);
      await _notifier.login(result.sessionBody.key);
      return Result.success(result.sessionBody.name);
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
