import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
	final color;
	final horizontal;

	CircularIndicator() :
		color = Colors.white,
		horizontal = false;

	CircularIndicator.color(MaterialColor color) :
		color = color,
		horizontal = false;

	CircularIndicator.horizontal(MaterialColor color) :
		color = color,
		horizontal = true;

	build(context) {
		if (horizontal)
			return Row(
				children: [
					Expanded(child: Container(height: 20)),
					Container(
						height: 20,
						width: 20,
						margin: EdgeInsets.all(5),
						child: CircularProgressIndicator(
							strokeWidth: 2.0,
							valueColor : AlwaysStoppedAnimation(color),
						),
					),
					Expanded(child: Container(height: 20)),
				]
			);
		return Center(
			child: Container(
				height: 20,
				width: 20,
				margin: EdgeInsets.all(5),
				child: CircularProgressIndicator(
					strokeWidth: 2.0,
					valueColor : AlwaysStoppedAnimation(color),
				),
			),
		);
	}
}
