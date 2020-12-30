import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Ranking extends StatelessWidget {
	build(BuildContext context) {
		return Provider(
			child: View(),
			context: context
		);
	}
}
