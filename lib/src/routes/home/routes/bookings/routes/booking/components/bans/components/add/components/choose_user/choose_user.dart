import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class ChooseUser extends StatelessWidget {
	final bloc;

	ChooseUser({this.bloc});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			bloc: bloc
		);
	}
}

