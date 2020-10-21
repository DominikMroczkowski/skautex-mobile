import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'bloc/bloc.dart' as usersList;
import 'cost_tile.dart';


class UsersList extends StatelessWidget {

	Widget build(context) {
		return usersList.Provider(child: _View(), context: context);
	}
}

class _View extends StatelessWidget {

	Widget build(context) {
		final bloc = usersList.Provider.of(context);
		bloc.fetch();

		return StreamList(
			stream: bloc.watcher,
			tile: createCostTile
		);
	}
}
