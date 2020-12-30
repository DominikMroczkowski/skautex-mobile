import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';

class AddInvitation extends StatelessWidget {
	final Player player;
	final Function update;

	AddInvitation({@required this.player, @required this.update});

	Widget build(context) {
		return FloatingActionButton(
			child: Icon(Icons.add, color: Colors.white),
			onPressed: () {
				Navigator.of(context).pushNamed('/home/players/player/addInvitation', arguments: [player, update]);
			},
 		);
	}

}

