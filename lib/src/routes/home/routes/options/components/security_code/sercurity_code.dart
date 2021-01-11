import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class SecurityCode extends StatelessWidget {
	Widget build(context) {
		return Provider(
			child: View(),
			context: context
		);
	}
}
