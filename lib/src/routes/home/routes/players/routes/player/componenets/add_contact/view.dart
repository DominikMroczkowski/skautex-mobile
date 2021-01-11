import 'package:flutter/material.dart';

class View extends StatelessWidget {
	Widget build(context) {
		return FloatingActionButton(
			child: Icon(Icons.add, color: Colors.white),
			onPressed: () {
				Navigator.of(context).pushNamed('/home/players/player/addContact', arguments: [player, reload]);
			},
 		);
	}
}
