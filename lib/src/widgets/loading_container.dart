import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Card(
			child: Container(
				child: Column (
					children: [
						buildContainer(18.0),
						Container(margin: EdgeInsets.only(top: 10.0)),
						Row(children: <Widget>[
							buildContainer(14.0),
							Expanded(child: Container()),
							buildContainer(14.0),
							Expanded(child: Container()),
							buildContainer(14.0),
							],
						),
						Container(margin: EdgeInsets.only(top: 10.0)),
						Row(children: <Widget>[
							buildContainer(14.0),
							],
						),
					]
		    		),
				padding: EdgeInsets.all(20.0),
			),
			color: Colors.white,
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
