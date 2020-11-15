import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Items extends StatelessWidget {
	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View()
		);
	}
}

