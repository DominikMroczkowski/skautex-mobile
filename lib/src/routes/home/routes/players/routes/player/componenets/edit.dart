import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/routes/home/routes/players/bloc/bloc.dart' as playersBloc;

class Edit extends StatelessWidget {
	final Player player;

	Edit({@required this.player});

	Widget build(context) {
		return FlatButton(
			child: Icon(Icons.edit, color: Colors.white),
			onPressed: () {
				playersBloc.Provider.of(context).navigator.currentState.pushNamed('/home/players/editPlayer', arguments: player);
			},
			shape: CircleBorder(),
			minWidth: 10.0
 		);
	}

}
