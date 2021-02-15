import 'package:flutter/material.dart';

import 'package:skautex_mobile/src/helpers/widgets/home_drawer.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as info;
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/helpers/widgets/search_bar/search_bar.dart';

import 'componenets/player_tile.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);
		final infoBloc = info.Provider.of(context);

		return Scaffold(
			body: _playerList(bloc),
			appBar: AppBar(
				title: SearchBar(change: null, title: 'Zawodnicy')
			),
			drawer: HomeDrawer(),
			floatingActionButton: _addButton(infoBloc, bloc),
		);
	}

	Widget _playerList(Bloc bloc) {
		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (p) => PlayerTile(player: p, reload: bloc.reloadPlayers),
			notify: bloc.fetch
		);
	}

	Widget _addButton(info.Bloc infoBloc, Bloc bloc) {
		return StreamBuilder(
			stream: infoBloc.permissions,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, futureSnap) {
							if (!futureSnap.hasData || !(futureSnap.data as Permissions).addPlayer) {
								return Container();
							}

							return FloatingActionButton(
     						onPressed: () {
									Navigator.of(context).pushNamed('/home/players/addPlayer', arguments: bloc.reloadPlayers);
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
