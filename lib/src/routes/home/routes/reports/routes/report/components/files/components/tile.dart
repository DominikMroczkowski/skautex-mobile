import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/file.dart';

class Tile extends StatelessWidget {
	final File file;

	Tile({this.file});

	Widget build(context) {
		print(file.uri);
		return Container(
			child: buildTile(context, file),
			padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget buildTile(BuildContext context, File file) {
		return Card(
			child: ExpansionTile(
				title: Text(file.toString()),
			)
		);
	}
}
