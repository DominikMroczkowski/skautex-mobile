import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'package:skautex_mobile/src/routes/home/routes/task/bloc/bloc.dart';

class Tile extends StatelessWidget {
	final Event event;
	final Bloc bloc;

	Tile({this.event, this.bloc});

	Widget build(context) {
		return Container(
			child: _tile(context),
			padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget _tile(BuildContext context) {
		return Card(
			child: ListTile(
				leading: Text(event.name),
				onTap: () {
					Navigator.of(context).pushNamed('/home/calendar/event', arguments: event);
				}
			),
		);
	}
}
