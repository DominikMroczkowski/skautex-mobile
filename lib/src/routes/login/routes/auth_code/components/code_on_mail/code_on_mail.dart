import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class CodeOnMail extends StatelessWidget {
	Widget build(context) {
		return Provider(
			child: View(),
			context: context,
		);
	}
}


