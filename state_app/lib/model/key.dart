import 'package:envied/envied.dart';

part 'key.g.dart';

@envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static const String apiKey = _Env.apiKey;

  @EnviedField(varName: 'SHARED_SECRET', obfuscate: true)
  static const String sharedSecret = _Env.sharedSecret;
}
