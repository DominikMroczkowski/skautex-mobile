import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/others/event_colors.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'bloc/bloc.dart';
import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendar;

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamList(
			itemsWatcher: calendar.Provider.of(context).itemsWatcher,
			tile: (event) => _Tile(event: event),
			controller: bloc.controller
		);
	}
}

class _Tile extends StatelessWidget {
	final Event event;

	_Tile({this.event});

	Widget build(BuildContext context) {
		return Card(
			child: _tile(context)
		);
	}

	_tile(context) {
		return ListTile(
			title: Column(children: [Text(event.name + ' - ' + event.owner.username), Container(height: 2.0, color: HexColor(event.color) )],),
			subtitle: Text('Od: ' + event.startDate + ' \nDo: ' + event.endDate),
			isThreeLine: true,
			dense: true,
			enabled: true,
			onTap: () {
				Navigator.of(context).pushNamed('/home/calendar/event', arguments: event);
			}
		);
	}
}
