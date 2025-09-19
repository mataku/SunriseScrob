import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sunrisescrob/model/profile/user_info.dart';
import 'package:sunrisescrob/repository/profile_repository.dart';
import 'package:sunrisescrob/store/session_store.dart';
import 'package:sunrisescrob/ui/account/account_content.dart';
import 'package:sunrisescrob/ui/common/theme_notifier.dart';

final accountNotifierProvider = ChangeNotifierProvider((ref) {
  final notifier = AccountNotifier(
    profileRepository: ref.read(profileRepositoryProvider),
  );
  notifier.fetchUserInfo();
  return notifier;
});

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(accountNotifierProvider);
    final sessionChangeNotifier = ref.watch(sessionChangeNotifierProvider);
    final themeNotifier = ref.watch(themeNotifierProvider);
    final userInfo = notifier.userInfo;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Account',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          surfaceTintColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(12),
            child: Divider(
              color: theme.colorScheme.onSecondary.withAlpha(128),
            ),
          ),
          centerTitle: false,
        ),
        body: AccountContent(
          userInfo,
          themeNotifier.appTheme,
          () {
            sessionChangeNotifier.logout();
          },
        ),
      ),
    );
  }
}

class AccountNotifier extends ChangeNotifier {
  final ProfileRepository _profileRepository;

  AccountNotifier({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  UserInfo? userInfo;

  Future fetchUserInfo() async {
    final userInfoResult = await _profileRepository.getUserInfo();
    userInfo = userInfoResult.getOrNull();
    notifyListeners();
  }
}
