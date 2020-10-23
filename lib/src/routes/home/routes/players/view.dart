import 'package:flutter/material.dart';

import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/helpers/widgets/playerTile.dart';
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

	Widget _playerList(players.Bloc p) {
		return StreamBuilder(
			stream: p.watcher,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return Center(
						child: CircularProgressIndicator()
					);
				}

				return FutureBuilder(
					future: snapshot.data,
					builder: (context, AsyncSnapshot<List<Player>> snapshot) {
						if (!snapshot.hasData) {
							return Center(
								child: CircularProgressIndicator()
							);
						}

						return ListView.builder(
							itemCount: snapshot.data.length,
							itemBuilder: (context, int index) {
								return PlayerTile(
									player: snapshot.data[index]
								);
							}
						);
					}
				);
			}
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
