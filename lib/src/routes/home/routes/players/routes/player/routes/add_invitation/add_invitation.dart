import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'bloc/bloc.dart';
import 'view.dart';

class AddInvitation extends StatelessWidget {
	final Player player;
	final Function updateUpperPage;

	AddInvitation({@required this.player, @required this.updateUpperPage});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			player: player,
			update: updateUpperPage
		);
	}
}

