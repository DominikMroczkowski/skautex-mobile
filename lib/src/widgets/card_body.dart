import 'package:flutter/material.dart';

class CardBody {
	final List<Widget> children;

	CardBody({this.children});

	build(context) {
		List<Widget> children = List<Widget>();
		this.children.forEach( (i) {
				children.add(Container(padding: EdgeInsets.only(top: 10)));
				children.add(i);
			}
		);

		return Container(
			child: Card(
					child: Container(
						child: Column(
							children: children
						),
					padding: EdgeInsets.all(15.0),
					),
				),
			margin: EdgeInsets.all(15.0),
			);
	}
}
