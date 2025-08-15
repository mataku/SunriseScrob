import 'package:alchemist/alchemist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sunrisescrob/repository/auth_repository.dart';
import 'package:sunrisescrob/ui/auth/login_screen.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

import '../../support/device.dart';
import '../../support/golden_test_device_scenario.dart';
import '../../testable_app.dart';
import 'login_screen_golden_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      ciGoldensConfig: CiGoldensConfig(
        obscureText: false,
        renderShadows: true,
      ),
      platformGoldensConfig: const PlatformGoldensConfig(
        enabled: false,
      ),
    ),
    run: () {
      final repo = MockAuthRepository();
      group('LoginScreen_light', () {
        final devices = Device.lightTargets;
        final children = devices.map((device) {
          return GoldenTestDeviceScenario(
            name: device.name,
            device: device,
            builder: () => ProviderScope(
              overrides: [
                loginNotifierProvider.overrideWith((ref) {
                  LoginNotifier loginNotifier =
                      LoginNotifier(authRepository: repo);
                  return loginNotifier;
                }),
              ],
              child: testableApp(
                child: LoginScreen(),
                appTheme: AppTheme.light,
              ),
            ),
          );
        }).toList();

        goldenTest(
          'login',
          fileName: 'login_light',
          builder: () {
            return GoldenTestGroup(
              columns: devices.length,
              children: children,
            );
          },
        );
      });

      group('LoginScreen_dark', () {
        final devices = Device.darkTargets;
        final children = devices.map((device) {
          return GoldenTestDeviceScenario(
            name: device.name,
            device: device,
            builder: () => ProviderScope(
              overrides: [
                loginNotifierProvider.overrideWith((ref) {
                  LoginNotifier loginNotifier =
                      LoginNotifier(authRepository: repo);
                  return loginNotifier;
                }),
              ],
              child: testableApp(
                child: LoginScreen(),
                appTheme: AppTheme.dark,
              ),
            ),
          );
        }).toList();

        goldenTest(
          'login',
          fileName: 'login_dark',
          builder: () {
            return GoldenTestGroup(
              columns: devices.length,
              children: children,
            );
          },
        );
      });

      group('LoginScreen_lastfm_dark', () {
        final devices = Device.darkTargets;
        final children = devices.map((device) {
          return GoldenTestDeviceScenario(
            name: device.name,
            device: device,
            builder: () => ProviderScope(
              overrides: [
                loginNotifierProvider.overrideWith((ref) {
                  LoginNotifier loginNotifier =
                      LoginNotifier(authRepository: repo);
                  return loginNotifier;
                }),
              ],
              child: testableApp(
                child: LoginScreen(),
                appTheme: AppTheme.lastfmDark,
              ),
            ),
          );
        }).toList();

        goldenTest(
          'login',
          fileName: 'login_lastfm_dark',
          builder: () {
            return GoldenTestGroup(
              columns: devices.length,
              children: children,
            );
          },
        );
      });
    },
  );
}
