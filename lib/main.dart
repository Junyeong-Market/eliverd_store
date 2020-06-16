import 'dart:async';

import 'package:flutter/material.dart';

import 'package:Eliverd/ui/pages/splash_screen.dart';

import 'package:Eliverd/common/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = EliverdBlocDelegate();

  runApp(EliverdStore());
}

class EliverdStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: eliverdTheme,
      home: SplashScreenPage(),
    );
  }
}

class EliverdBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}