import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';

class Edit extends StatelessWidget {
	final GlobalKey<NavigatorState> navigator;
	final Event event;
	final eventBloc;

	Edit({this.navigator, this.event, this.eventBloc});

	Widget build(context) {
		return FlatButton(
			child: Icon(
				Icons.edit,
				color: Colors.white
			),
			onPressed: () {
				Navigator.of(context).pushNamed("/home/calendar/event/edit", arguments: [event, eventBloc]);
			},
			shape: CircleBorder(),
			minWidth: 10.0
 		);
	}
}
