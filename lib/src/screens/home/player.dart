import 'package:flutter/material.dart';
import '../../widgets/homeDrawer.dart';

import '../../blocs/session/bloc.dart' as session;

class Player extends StatelessWidget {

	Widget build(context) {
		final s = session.Provider.of(context);
		return Scaffold(
			body: SafeArea(
				child: _playerList(s),
			),
			appBar: AppBar(
				title: Text('Skautex')
			),
			drawer: HomeDrawer()
		);
	}

	Widget _playerList(session.Bloc s) {
		return StreamBuilder(
			stream: s.players,
			builder: (context, snapshot) {

			},
		);
	}
}
