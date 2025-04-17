import 'package:envied/envied.dart';

part 'key.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final String apiKey = _Env.apiKey;

  @EnviedField(varName: 'SHARED_SECRET', obfuscate: true)
  static final String sharedSecret = _Env.sharedSecret;
}
