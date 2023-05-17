import 'dart:async';
import 'dart:developer';

import 'package:celenganku/app.dart';
import 'package:celenganku/initialize.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await initialize();
  runZonedGuarded(() => runApp(const MyApp()), (error, stack) {
    log(error.toString(), stackTrace: stack);
  });
}
