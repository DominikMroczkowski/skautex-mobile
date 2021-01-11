import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Download extends StatelessWidget {
	final File file;

	Download({this.file});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(file: file),
			file: file
		);
	}
}

