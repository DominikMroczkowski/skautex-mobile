import 'package:flutter/material.dart';
import '../../widgets/homeDrawer.dart';
import '../../widgets/playerTile.dart';

import '../../blocs/players/bloc.dart' as player;

class Player extends StatelessWidget {

	Widget build(context) {
		final p = player.Provider.of(context);
		p.fetchTopUris();

		return Scaffold(
			body: _playerList(p),
			appBar: AppBar(
				title: Text('Skautex')
			),
			drawer: HomeDrawer()
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
}
