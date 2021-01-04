import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Templates extends StatelessWidget {
	final Stream reload;

	Templates({@required this.reload});

	Widget build(context) {
		return Provider(
			child: View(),
			context: context,
			reaload: reload
		);
	}
}
