import 'package:flutter/material.dart';

// This widgets expect as its input list of values in format
// header, value

class ViewItemList extends StatelessWidget {
	final List<List<String>> item;
	final List<Widget> widget;

	ViewItemList(this.item):
			widget = null;

	ViewItemList.withCustomWidget(this.item, List<Widget> widget):
			widget = widget;

	build(BuildContext context) {
		List<Widget> items = [];
		item.asMap().forEach(
			(index, value) {
				items.add(
					_goldenRow(
						value[0],
						widget == null ? _header(value[1], Alignment.centerLeft) : widget[index]
					)
				);
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
