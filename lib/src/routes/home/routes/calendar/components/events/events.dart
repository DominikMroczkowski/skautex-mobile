import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Events extends StatelessWidget {

	final controller = AutoScrollController();

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			controller: controller
		);
	}
}
