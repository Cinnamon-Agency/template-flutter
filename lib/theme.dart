import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/colors.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.indigo,
  ),
  scaffoldBackgroundColor: MyColors.white,
  textTheme: GoogleFonts.robotoTextTheme(),
  cardTheme: const CardTheme(
    color: MyColors.green,
  ),
);
