import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Card(
				child: InkWell(
					child: Container(
						child: Column (
							children: [
								buildContainer(20.0),
								Container(margin: EdgeInsets.only(top: 10.0)),
								buildContainer(18.0),
								Container(margin: EdgeInsets.only(top: 10.0)),
								buildContainer(18.0),
							]
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
