import 'package:flutter/material.dart';

class Header extends StatelessWidget {
	final String text;

	Header({this.text});

	Widget build(BuildContext context) {
		return Align(
			child: Text(
				text,
				style: TextStyle(
					fontSize: 18,
				)
			),
			alignment: Alignment.topLeft,
		);
	}
}


