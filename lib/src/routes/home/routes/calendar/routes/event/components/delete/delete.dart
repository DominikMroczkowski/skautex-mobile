import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart' as models;
import 'view.dart';
import 'bloc/bloc.dart';

class Delete extends StatelessWidget {
	final models.Event event;
	Delete({this.event});

	Widget build(BuildContext context) {
		return Provider(
			event: event,
			child: View(),
		);
	}
}

