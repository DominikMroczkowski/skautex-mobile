import 'package:flutter/material.dart';
import '../models/player.dart';
import '../blocs/players/bloc.dart';

import 'dart:async';

import 'loading_container.dart';

class PlayerTile extends StatelessWidget {
	final String uri;

	PlayerTile({this.uri});

	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamBuilder(
			stream: bloc.player,
			builder: (context, AsyncSnapshot<Map<String, Future<Player>>> snapshot) {
				if (!snapshot.hasData) {
					return LoadingContainer();
				}

				return FutureBuilder(
					future: snapshot.data[uri],
					builder: (context, AsyncSnapshot<Player> playerSnap) {
						if (!playerSnap.hasData) {
							return LoadingContainer();
						}

						return Container(
							child: buildTile(context, playerSnap.data),
							padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
						);

					}
				);
			}
		);
	}

	Widget buildTile(BuildContext context, Player player) {
		return Card(
			child: InkWell(
				child: Container(
					child: Column (
						children: [
							Align(
								child: Text(
									'${player.name} ${player.surname}',
									style: TextStyle(
										fontSize: 18,
									)
								),
								alignment: Alignment.topLeft,
							),
							Container(margin: EdgeInsets.only(top: 10.0)),
							Row(children: <Widget>[
								Text(
									player.position,
									style: TextStyle(
										color: Colors.grey[700],
									)
								),
								Container(
									padding: EdgeInsets.only(left: 20.0),),
								Text(
									'Grupa Wiekowa',
									style: TextStyle(
										color: Colors.grey[700],
									)
								),

								Expanded(child: Container()),
								Text(
									player.team,
									style: TextStyle(
										color: Colors.grey[700],
									)
								),
								],
							),
							Container(margin: EdgeInsets.only(top: 10.0)),
							Row(children: <Widget>[
								_playerStatus('Okej'),
								Expanded(child: Container()),
								Text(player.city),
								],
							),
						]
		    			),
					padding: EdgeInsets.all(20.0),
				),
			onTap: () {
					// Navigator.pushNamed(context, '/${player.uri}');
			}),
			color: Colors.white,
		);
	}

	Widget _playerStatus(String status) {
		return Row(
			children: <Widget>[
				Icon(
      					Icons.check_circle,
      					color: Colors.green
    				),
				Text(status)
			],
		);
	}
}
