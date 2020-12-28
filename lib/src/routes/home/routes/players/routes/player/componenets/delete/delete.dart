import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final Player player;
	final Function updateUpperPage;

	Delete({@required this.player, this.updateUpperPage});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			player: player,
			updateUpperPage: updateUpperPage
		);
	}
}

