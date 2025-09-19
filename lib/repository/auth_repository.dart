import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/api/endpoint/auth_get_mobile_session_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/lastfm_api_signature.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/store/session_store.dart';

part 'auth_repository.g.dart';

@Riverpod(dependencies: [lastFmApiService])
AuthRepository authRepository(Ref ref) {
  return _AuthRepositoryImpl(
    ref.read(lastFmApiServiceProvider),
    ref.read(sessionChangeNotifierProvider),
  );
}

abstract class AuthRepository {
  Future<Result<String>> authorize({
    required String username,
    required String password,
  });
}

class _AuthRepositoryImpl implements AuthRepository {
  final LastFmApiService _apiService;
  // TODO: reconsider
  final SessionChangeNotifier _notifier;

  _AuthRepositoryImpl(
    this._apiService,
    this._notifier,
  );

  @override
  Future<Result<String>> authorize({
    required String username,
    required String password,
  }) async {
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
      await _notifier.login(
        sessionKey: result.sessionBody.key,
        username: result.sessionBody.name,
      );
      return Result.success(result.sessionBody.name);
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
