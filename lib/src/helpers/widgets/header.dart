import 'package:flutter/material.dart';

class Header extends StatelessWidget {
	final String text;
	final double fontSize;

	Header({this.text, this.fontSize});

	Widget build(BuildContext context) {
		return Align(
			child: Text(
				text,
				style: TextStyle(
					fontSize: fontSize ?? 18,
				),
				overflow: TextOverflow.clip
			),
			alignment: Alignment.topLeft,
		);
	}
}


