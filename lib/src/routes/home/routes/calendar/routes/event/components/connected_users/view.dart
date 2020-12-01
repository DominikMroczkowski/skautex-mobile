import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);
		return StreamList(
			stream: bloc.watcher,
			tile: (User u) => _tile(u)
		);
	}

	Widget _tile(User user) {
		return Card(
			child: ListTile(
				title: Text(user.username)
			)
		);
	}
}
