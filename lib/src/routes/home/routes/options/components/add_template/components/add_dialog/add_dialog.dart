import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class AddDialog extends StatelessWidget {
	final Function reloadTemplates;

	AddDialog({this.reloadTemplates});

	Widget build(context) {
		return Provider(
			child: View(),
			reloadTemplates: reloadTemplates,
			context: context
		);
	}
}

