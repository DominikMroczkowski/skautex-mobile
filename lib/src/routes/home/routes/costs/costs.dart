import 'package:flutter/material.dart';
import 'bloc/bloc.dart' as costs;
import 'view.dart';

class Costs extends StatelessWidget {
	Widget build(BuildContext context) {
		return costs.Provider(
			context: context,
			child: View()
		);
	}
}
