import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Tile extends StatelessWidget {
	final File file;

	Tile({@required this.file});

	Widget build(BuildContext context) {
		return Provider(
			child: View(file: file),
			context: context,
			file: file
		);
	}
}

