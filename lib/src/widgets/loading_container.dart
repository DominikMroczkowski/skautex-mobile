import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
	final int lineCount;

	LoadingContainer() :
		lineCount = 0;

	LoadingContainer.lineCount(int lineCount) :
		lineCount = lineCount;

	@override
	Widget build(BuildContext context) {
		List<Widget> children = List<Widget>();

		children.add(buildContainer(20));

		for (int i = 0; i < lineCount; i++) {
			children.add(Container(padding: EdgeInsets.only(top: 10)));
			children.add(buildContainer(18));
		}

		return Container(
			child: Card(
				child: InkWell(
					child: Container(
						child: Column (
							children: children
			    	),
						padding: EdgeInsets.all(20.0),
					)
				),
				color: Colors.white,
			),
			padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
		);
	}

	Widget buildContainer(double height) {
		return Container(
			color: Colors.grey[200],
			height: height,
			margin: EdgeInsets.only(),
		);
	}
}
