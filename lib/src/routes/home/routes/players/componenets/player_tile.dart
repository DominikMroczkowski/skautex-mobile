import 'package:flutter/material.dart';

import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/helpers/others/player_statuses.dart';
import 'package:skautex_mobile/src/helpers/positions.dart';

class PlayerTile extends StatelessWidget {
	final Player player;
	final Function reload;

	PlayerTile({this.player, this.reload});

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
									player.position == null ? 'Brak' : getPolishPosition(player.position),
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
				Navigator.of(context).pushNamed('/home/players/player', arguments: [player, reload]);
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
