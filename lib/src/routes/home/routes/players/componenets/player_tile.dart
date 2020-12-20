import 'package:flutter/material.dart';

import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/helpers/others/player_statuses.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as session;

class PlayerTile extends StatelessWidget {
	final Player player;

	PlayerTile({this.player});

	Widget build(context) {
		return Container(
			child: buildTile(context, player),
			padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
		);
	}

	Widget buildTile(BuildContext context, Player player) {
		return Card(
			child: InkWell(
				child: Container(
					child: Column (
						children: [
							Row(children: [
								Text(
									'${player.name} ${player.surname}' ?? 'Brak',
									style: TextStyle(
										fontSize: 18,
									)
								),
								Expanded(child: Container()),
								_playerStatus(player.status)
							]),
							Container(margin: EdgeInsets.only(top: 10.0)),
							Row(children: <Widget>[
								Text(
									player.birthDate,
									style: TextStyle(
										color: Colors.grey[700],
									)
								),
								Expanded(child: Container()),
								Text(
									player.position ?? 'Brak',
									style: TextStyle(
										color: Colors.grey[700],
									)
								),
								]
							),
							Container(margin: EdgeInsets.only(top: 10.0)),
							Row(children: <Widget>[
								Text(
									player.team[0] ?? 'Brak',
									style: TextStyle(
										color: Colors.grey[700],
									)
								),
								Expanded(child: Container()),
								Text(player.city ?? 'Brak',
										style: TextStyle(
										color: Colors.grey[700],
									)

								),
								],
							),
						]
		    			),
					padding: EdgeInsets.all(20.0),
				),
			onTap: () {
				final s = session.Provider.of(context);
				s.changeClicked(player.uri);
				Navigator.pushNamed(context, '/home/players/player', arguments: player);
			}),
			color: Colors.white,
		);
	}

	Widget _playerStatus(String status) {
		final color = getPlayerStatusColor(status);
		return Icon(
      Icons.circle,
      color: color
    );
	}
}
