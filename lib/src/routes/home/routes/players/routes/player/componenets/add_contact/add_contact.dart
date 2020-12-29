import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';

class AddContact extends StatelessWidget {
	final Function reloadContacts;
	final Player player;

	AddContact({this.player, this.reloadContacts});

	Widget build(context) {
		return FloatingActionButton(
			child: Icon(Icons.add, color: Colors.white),
			onPressed: () {
				Navigator.of(context).pushNamed('/home/players/player/addContact', arguments: [player, reloadContacts]);
			},
 		);
	}
}
