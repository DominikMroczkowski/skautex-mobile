import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class ChooseTemplate extends StatelessWidget {
	final Function(String) change;

	ChooseTemplate({@required this.change});

	build(BuildContext context) {
		return Provider(
			child: View(),
			context: context,
			change: change
		);
	}
}
