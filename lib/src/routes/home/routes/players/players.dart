import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Players extends StatelessWidget {

	Widget build(context) {
		return Provider(
			context: context,
			child: View(),
		);
	}
}


