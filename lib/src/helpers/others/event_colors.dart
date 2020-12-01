import 'package:flutter/material.dart';

final List<String> eventColors = [
	"#1FBC9C",
	"#1CA085",
	"#2ECC70",
	"#27AF60",
	"#3398DB",
	"#2980B9",
	"#A463BF",
	"#8E43AD",
	"#3D556E",
	"#222F3D",
	"#F2C511",
	"#F39C19",
	"#E84B3C",
	"#C0382B",
	"#DDE6E8",
	"#BDC3C8"
];

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
