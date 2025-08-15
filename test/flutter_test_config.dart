import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      final font = rootBundle.load('asset/font/NotoSansJP-Regular.ttf');
      final fontLoader = FontLoader('Noto Sans JP')..addFont(font);
      await fontLoader.load();
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () {
        return Platform.isIOS || Platform.isAndroid;
      },
      defaultDevices: const [
        Device.iphone11,
      ],
    ),
  );

  // TODO
  // return AlchemistConfig.runWithConfig(
  //   config: AlchemistConfig(
  //     ciGoldensConfig: CiGoldensConfig(
  //       obscureText: false,
  //       renderShadows: true,
  //     ),
  //     platformGoldensConfig: const PlatformGoldensConfig(
  //       enabled: false,
  //     ),
  //   ),
  //   run: testMain,
  // );
}
