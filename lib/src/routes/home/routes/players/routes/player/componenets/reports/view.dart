import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			scrollable: false,
			tile: (i) => _tile(i, bloc, context)
		);
	}

	Widget _tile(PlayerReport i, Bloc bloc, BuildContext context) {
		return Card(
			child: ListTile(
				title: Text('Ocena: ' + i.rating.toStringAsFixed(2)),
				subtitle: Text("Status : " + i.status),
				onTap: () {
					Navigator.of(context).pushNamed('/home/players/player/report', arguments: [i, null]);
				},
			),
		);
	}
}
