import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/header.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'bloc/bloc.dart';
import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendar;


class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamList(
			stream: calendar.Provider.of(context).watcher,
			tile: _tile,
			controller: bloc.controller
		);
	}

	Widget _tile(Event event) {
		return Card(
				child:  ListTile(
					title: Text(event.name + ' - ' + event.owner.username),
					subtitle: Text('Od: ' + event.startDate + ' \nDo: ' + event.endDate),
					isThreeLine: true,
					dense: true,
				),
				color: Color(int.parse(event.color.substring(1), radix: 16) + 0x11000000),
				margin: EdgeInsets.fromLTRB(8.0,8.0,8.0,0.0),
		);
	}
}
