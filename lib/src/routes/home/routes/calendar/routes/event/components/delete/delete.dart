import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart' as models;
import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendar;
import 'view.dart';
import 'bloc/bloc.dart';

class Delete extends StatelessWidget {
	final models.Event event;
	Delete({this.event, this.navigator});
	final GlobalKey<NavigatorState> navigator;


	Widget build(BuildContext context) {
		return Provider(
			context: context,
			event: event,
			child: View(),
			navigator: calendar.Provider.of(context).navigator
		);
	}
}

