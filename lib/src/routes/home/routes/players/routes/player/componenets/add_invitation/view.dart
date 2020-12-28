import 'package:flutter/material.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return FloatingActionButton(
			child: Icon(Icons.add, color: Colors.white),
			onPressed: () {
				Navigator.of(context).pushNamed('/home/players/player/addInvitation');
			},
 		);
	}

}
