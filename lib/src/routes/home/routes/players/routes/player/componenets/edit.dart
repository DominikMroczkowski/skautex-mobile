import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';

class Edit extends StatelessWidget {
	final Player player;
	final Function updateUpperPage;

	Edit({@required this.player, this.updateUpperPage});

	Widget build(context) {
		return FlatButton(
			child: Icon(Icons.edit, color: Colors.white),
			onPressed: () {
				Navigator.of(context).pushNamed('/home/players/editPlayer', arguments: [player, updateUpperPage]);
			},
			shape: CircleBorder(),
			minWidth: 10.0
 		);
	}

}
