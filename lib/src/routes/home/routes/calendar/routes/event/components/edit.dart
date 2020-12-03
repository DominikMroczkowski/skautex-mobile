import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';

class Edit extends StatelessWidget {
	final GlobalKey<NavigatorState> navigator;
	final Event event;

	Edit({this.navigator, this.event});

	Widget build(context) {
		return FlatButton(
			child: Icon(
				Icons.edit,
				color: Colors.white
			),
			onPressed: () {
				navigator.currentState.pushNamed("/home/calendar/event/edit", arguments: event);
			},
			shape: CircleBorder(),
			minWidth: 10.0
 		);
	}
}
