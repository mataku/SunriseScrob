import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:sunrisescrob/repository/auth_repository.dart';
import 'package:sunrisescrob/ui/common/app_button.dart';
import 'package:sunrisescrob/ui/common/app_dialog.dart';

final loginNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => LoginNotifier(
    authRepository: ref.read(authRepositoryProvider),
  ),
);

class LoginScreen extends ConsumerWidget {
  final usernameTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(loginNotifierProvider);
    final errorMessage = notifier.error;
    final theme = Theme.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (errorMessage?.isNotEmpty == true) {
        _showErrorMessage(context, errorMessage!, () {
          debugPrint("MATAKUDEBUG consume!");
          notifier.consume();
        });
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Login to Last.fm',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 24)),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: usernameTextEditController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: theme.colorScheme.onSurface),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    focusColor: theme.colorScheme.onSurface,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is empty';
                    }
                    return null;
                  },
                  cursorColor: theme.colorScheme.onSecondary,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                  ),
                  controller: passwordTextEditController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: theme.colorScheme.onSurface),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    focusColor: theme.colorScheme.onSurface,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is empty';
                    }

                    return null;
                  },
                  cursorColor: theme.colorScheme.onSecondary,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 48)),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: AppButton(
                  text: 'Let me in!',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      notifier.login(
                        username: usernameTextEditController.text,
                        password: passwordTextEditController.text,
                      );
                    }
                  },
                  backgroundColor: const Color(0xFFC0CA33),
                  textColor: theme.colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showErrorMessage(
  BuildContext context,
  String message,
  VoidCallback onConfirm,
) {
  if (Platform.isAndroid) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: message,
        description: 'Invalid username or password',
        dismissOnTap: null,
        confirmOnTap: () {
          GoRouter.of(context).pop();
          onConfirm();
        },
      ),
    );
  }
}

class LoginNotifier extends ChangeNotifier {
  final AuthRepository _authRepository;
  String? error;

  LoginNotifier({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future login({required String username, required String password}) async {
    error = null;
    final result = await _authRepository.authorize(
      username: username,
      password: password,
    );
    debugPrint("MATAKUDEBUG result $result");
    if (result.isFailure()) {
      error = 'Failed to login';
    }
    notifyListeners();
  }

  void consume() {
    error = null;
    notifyListeners();
  }
}
