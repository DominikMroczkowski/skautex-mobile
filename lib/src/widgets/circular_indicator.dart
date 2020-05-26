import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {

	build(context) {
		return Center(
			child: Container(
				height: 20,
				width: 20,
				margin: EdgeInsets.all(5),
				child: CircularProgressIndicator(
					strokeWidth: 2.0,
					valueColor : AlwaysStoppedAnimation(Colors.white),
				),
			)
		);
	}
}
