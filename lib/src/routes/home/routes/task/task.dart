import 'package:flutter/material.dart';
import 'view.dart';
import 'bloc/bloc.dart';

class Task extends StatelessWidget {
	Widget build(context) {
		return Provider(
			context: context,
			child: View()
		);
	}
}



