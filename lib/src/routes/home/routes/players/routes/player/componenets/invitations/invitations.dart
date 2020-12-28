import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Invitations extends StatelessWidget {
	final Player player;

	Invitations({@required this.player});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			player: player
		);
	}
}

