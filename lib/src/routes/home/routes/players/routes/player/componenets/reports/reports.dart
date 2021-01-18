import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Reports extends StatelessWidget {
	final Player player;

	Reports ({@required this.player});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			player: player,
		);
	}
}

