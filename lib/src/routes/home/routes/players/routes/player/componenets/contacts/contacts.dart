import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Contacts extends StatelessWidget {
	final Player player;
	final Stream contacts;
	final Function update;

	Contacts({@required this.player, @required this.contacts, @required this.update});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			player: player,
			contacts: contacts,
			update: update
		);
	}
}

