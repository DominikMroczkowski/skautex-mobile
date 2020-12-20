import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:path/path.dart';

import 'components/download/download.dart';
import 'components/delete/delete.dart';

class View extends StatelessWidget {
	final File file;

	View({this.file});

	Widget build(context) {
		print(file.uri);
		return Container(
			child: buildTile(context, file),
			padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget buildTile(BuildContext context, File file) {
		return Card(
			child: ListTile(
				title: Text(basename(file.file)),
				trailing: _menu(context)
			)
		);
	}

	Widget _menu(BuildContext context) {
		final items = <PopupMenuItem>[
			PopupMenuItem(child: Download(file: file), enabled: false),
			PopupMenuItem(child: Delete(file: file), enabled: false)
		];
		return PopupMenuButton(
			itemBuilder:(_) => items
		);
	}
}
