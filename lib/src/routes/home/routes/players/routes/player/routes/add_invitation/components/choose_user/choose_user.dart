import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class ChooseUser extends StatelessWidget {
	final Function(String) change;

	ChooseUser({@required this.change});

	build(BuildContext context) {
		return Provider(
			child: View(),
			context: context,
			change: change
		);
	}
}
