import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/store/kv_store.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

part 'theme_repository.g.dart';

@Riverpod(dependencies: [kvStore])
ThemeRepository themeRepository(Ref ref) {
  return _ThemeRepositoryImpl(
    kvStore: ref.read(kvStoreProvider),
  );
}

abstract class ThemeRepository {
  Future<AppTheme> getCurrentTheme();
  Future<void> setTheme(AppTheme theme);
}

class _ThemeRepositoryImpl implements ThemeRepository {
  final KVStore kvStore;

  const _ThemeRepositoryImpl({
    required this.kvStore,
  });

  @override
  Future<AppTheme> getCurrentTheme() async {
    final currentThemeId = await kvStore.getStringValue(KVStoreKey.theme);
    final appTheme = AppTheme.values
            .firstWhereOrNull((value) => value.id == currentThemeId) ??
        AppTheme.dark;
    return appTheme;
  }

  @override
  Future<void> setTheme(AppTheme theme) async {
    await kvStore.setStringValue(KVStoreKey.theme, theme.id);
  }
}
