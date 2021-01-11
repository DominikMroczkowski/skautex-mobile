import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'bloc/bloc.dart';
import 'view.dart';

class EditPlayer extends StatelessWidget {
	final Player player;
	final Function updateUpperPage;

	EditPlayer({@required this.player, @required this.updateUpperPage});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			player: player,
			updateUpperPage: updateUpperPage
		);
	}
}

