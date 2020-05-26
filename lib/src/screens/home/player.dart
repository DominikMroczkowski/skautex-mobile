import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/widgets/permsWatcher.dart';
import '../../widgets/homeDrawer.dart';
import '../../widgets/playerTile.dart';

import '../../blocs/players/bloc.dart' as player;
import '../../blocs/user/bloc.dart' as user;

import '../../models/permissions.dart';

class Player extends StatelessWidget {

	Widget build(context) {
		final p = player.Provider.of(context);
		p.fetchTopUris();

		final u = user.Provider.of(context);

		return PermsWatcher.watcher(context,
			Scaffold(
				body: _playerList(p),
				appBar: AppBar(
					title: Text('Skautex')
				),
				drawer: HomeDrawer(),
				floatingActionButton: _addButton(u),
			)
		);
	}

	Widget _playerList(player.Bloc p) {
		return StreamBuilder(
			stream: p.topUris,
			builder: (context, snapshot) {
				if (!snapshot.hasData) {
					return Center(
						child: CircularProgressIndicator()
					);
				}

				return ListView.builder(
					itemCount: snapshot.data.length,
					itemBuilder: (context, int index) {
						p.fetchPlayer(snapshot.data[index]);

						return PlayerTile(
							uri: snapshot.data[index]
						);
					}
				);
			}
		);
	}

	Widget _addButton(user.Bloc u) {
		return StreamBuilder(
			stream: u.permissions,
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
									Navigator.of(context).pushNamed('/home/player/addPlayer');
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
