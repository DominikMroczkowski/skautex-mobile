import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class DateField extends StatelessWidget {
	final change;
	final String name;
	final stream;
	final DateTime init;

	DateField({this.change, this.name, this.stream, this.init});

	Widget build(BuildContext context) {
		return Provider(
			child: View(name: name),
			change: change,
			stream: stream,
			init: init
		);
	}
}

