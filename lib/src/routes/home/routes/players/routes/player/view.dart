import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';

import 'componenets/delete/delete.dart';
import 'componenets/edit.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final p = Provider.of(context);
		return StreamBuilder(
			stream: p.player,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return _scaffold(context, snapshot.data, p);
				return Center(child: Text('Brak danych'));
			},
		);
	}

	Widget _scaffold(BuildContext context, Player player, Bloc p) {
		return Scaffold(
			body: body(context, p),
			appBar: AppBar(
				title: Text(player.toString()),
				actions: [
					Delete(player: player),
					Edit(player: player)
				],
			),
		);
	}

	body(context, Bloc p) {
		return SingleChildScrollView(
			child: _player(p)
		);
	}


	Widget _player(Bloc p) {
		return StreamBuilder(
			stream: p.player,
			builder: (context, snapshot) {
				if (snapshot.hasData)
					return _buildPlayer(snapshot.data);
				return CircularIndicator.color(Colors.blue);
			}
		);
	}

	Widget _buildPlayer(Player data) {
		final list = data.toList();
		List<Widget> items = [];

		list.forEach(
			(i) {
				items.add(
					_padding(TextFormField(
						enabled: false,
						initialValue: i[1],
						decoration: InputDecoration(
							labelText: i[0]
						),
					)
					)
				);
			}
		);

		return Column(
			children: items
		);
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(5.0)
		);
	}
}
