import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
	final color;

	CircularIndicator() :
		color = Colors.white;

	CircularIndicator.color(MaterialColor color) :
		color = color;

	build(context) {
		return Center(
			child: Container(
				height: 20,
				width: 20,
				margin: EdgeInsets.all(5),
				child: CircularProgressIndicator(
					strokeWidth: 2.0,
					valueColor : AlwaysStoppedAnimation(color),
				),
			)
		);
	}
}
