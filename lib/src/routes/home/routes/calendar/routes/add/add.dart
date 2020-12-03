import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Add extends StatelessWidget {
	final Event event;

	Add({this.event});

	Widget build(BuildContext context) {
		print('Build event ' + event.toString());
		return Provider(
			context: context,
			child: View(event: event),
			event: event
		);
	}
}

