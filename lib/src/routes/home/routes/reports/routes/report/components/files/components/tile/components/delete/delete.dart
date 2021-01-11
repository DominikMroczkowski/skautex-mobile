import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final File file;
	final Function update;

	Delete({this.file, this.update});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(file: file),
			update: update
		);
	}
}

