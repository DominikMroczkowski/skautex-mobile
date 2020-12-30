import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Invitations extends StatelessWidget {
	final Player player;
	final Stream reload;

	Invitations({@required this.player, @required this.reload});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			player: player,
			reload: reload
		);
	}
}

