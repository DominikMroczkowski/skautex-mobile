import 'package:flutter/material.dart';

import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/helpers/widgets/playerTile.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as info;
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'bloc/bloc.dart' as players;

class View extends StatelessWidget {

	Widget build(context) {
		final p = players.Provider.of(context);
		p.fetch();

		final infoBloc = info.Provider.of(context);

		return Scaffold(
			body: _playerList(p),
			appBar: AppBar(
				title: Text('Skautex')
			),
			drawer: HomeDrawer(),
			floatingActionButton: _addButton(infoBloc),
		);
	}

	Widget _playerList(players.Bloc bloc) {
		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (p) => PlayerTile(player: p),
			notify: bloc.fetch
		);
	}

	Widget _addButton(info.Bloc infoBloc) {
		return StreamBuilder(
			stream: infoBloc.permissions,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, futureSnap) {
							if (!futureSnap.hasData || !(futureSnap.data as Permissions).addUser) {
								return Container();
							}

							return FloatingActionButton(
     						onPressed: () {
									Navigator.of(context).pushNamed('/home/players/addPlayer');
      					},
      					child: Icon(Icons.add),
      					backgroundColor: Colors.blue,
    					);
						}
					);
				}
				return Container();
			}
		);
	}
}
