import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final File file;

	Delete({this.file});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(file: file),
		);
	}
}

