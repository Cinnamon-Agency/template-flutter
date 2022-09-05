import 'package:flutter/material.dart';

import 'constants/colors.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.indigo,
  ),
  scaffoldBackgroundColor: MyColors.blue,
  cardTheme: const CardTheme(
    color: MyColors.green,
  ),
);
