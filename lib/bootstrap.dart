import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:local_data/local_data.dart';
import 'package:user_repository/user_repository.dart';

import 'screen/app/app.dart';
import 'screen/app/app_bloc_observer.dart';

void bootstrap({required LocalData localData}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(localData);

  final UserRepository userRepository = UserRepository(localData);


  runZonedGuarded(
    () => runApp(App(
      userRepository: userRepository,
      authenticationRepository: authenticationRepository,
    )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
