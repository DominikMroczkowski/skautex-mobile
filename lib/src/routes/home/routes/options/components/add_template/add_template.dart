import 'package:flutter/material.dart';
import 'components/add_dialog/add_dialog.dart';

class AddTemplate extends StatelessWidget {
	final Function reloadTemplates;

	AddTemplate({this.reloadTemplates});

	Widget build(context) {
		return FloatingActionButton(
			child: Icon(Icons.add, color: Colors.white),
			onPressed: () {
				showDialog(
					context: context,
					builder: (_) {
						return AddDialog(reloadTemplates: reloadTemplates);
					}
				);
			},
 		);
	}
}
