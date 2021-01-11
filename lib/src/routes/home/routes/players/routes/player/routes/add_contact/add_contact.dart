import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'bloc/bloc.dart';
import 'view.dart';

class AddContact extends StatelessWidget {
	final Function updateUpperPage;
	final Player player;

	AddContact({@required this.updateUpperPage, @required this.player});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			update: updateUpperPage,
			player: player
		);
	}
}

