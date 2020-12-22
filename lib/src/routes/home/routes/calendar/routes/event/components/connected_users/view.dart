import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/connected_users.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);
		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			tile: (ConnectedUser u) => _tile(u),
			scrollable: false
		);
	}

	Widget _tile(ConnectedUser user) {
		return Card(
			child: ListTile(
				title: Text(user.user.toString())
			)
		);
	}
}
