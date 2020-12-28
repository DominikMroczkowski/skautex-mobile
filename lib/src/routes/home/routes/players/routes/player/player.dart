import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart' as models;

import 'bloc/bloc.dart';
import 'view.dart';

class Player extends StatelessWidget {
	final models.Player player;
	final Function updateUpperPage;

	Player({@required this.player, this.updateUpperPage});

	Widget build(context) {
		return Provider(
			context: context,
			child: View(),
			player: player,
			reloadUpperPage: updateUpperPage
		);
	}
}
