import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

///
/// This is a class where all text styles are stored
/// You can then reference them in code with `MyTextStyles.someTextStyle`
///

class MyTextStyles {
  static final country = GoogleFonts.roboto(
    color: MyColors.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.6,
  );
  static final error = GoogleFonts.roboto(
    color: MyColors.red,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.6,
  );
}
