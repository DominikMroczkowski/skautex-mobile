import 'package:flutter/material.dart';

// This widgets expect as its input list of values in format
// header, value

class ViewItemList extends StatelessWidget {
	final List<List<String>> item;

	ViewItemList(this.item);

	build(BuildContext context) {
		List<Widget> items = [];
		item.forEach(
			(i) {
				items.add(_goldenRow(i[0], _header(i[1], Alignment.centerLeft)));
			}
		);

		return Column(
			children: items
		);
	}

	Widget _goldenRow(String name, Widget field) {
		return Container(
			height: 50.0,
			child: Row(
				children: <Widget>[
					Expanded(
						flex: 21,
						child: _header(name, Alignment.centerRight),
					),
					Container(
						padding: EdgeInsets.only(left: 10)
					),
					Expanded(
						flex: 34,
						child: field,
					)
				],
			)
		);
	}

	Widget _header(String name, Alignment alignment) {
		return Align(
			alignment: alignment,
			child: Text(
				name,
				style: TextStyle(
						fontSize: 16
				)
			)
		);
	}
}
