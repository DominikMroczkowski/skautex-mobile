import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Add extends StatelessWidget {
	final Event event;
	final eventBloc;

	Add({this.event, this.eventBloc});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(event: event),
			event: event,
			bloc: eventBloc
		);
	}
}

