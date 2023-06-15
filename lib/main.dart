import 'package:flutter/material.dart';
import 'package:local_data/local_data.dart';

import 'bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localData = LocalData(
    await SharedPreferences.getInstance(),
  );

  bootstrap(localData: localData);
}
