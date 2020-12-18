import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class CodeOnMail extends StatelessWidget {
	final sessionBloc;

	CodeOnMail({@required this.sessionBloc});

	Widget build(context) {
		return Provider(
			child: View(),
			sessionBloc: sessionBloc
		);
	}
}


