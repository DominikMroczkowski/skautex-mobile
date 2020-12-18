import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'bloc/bloc.dart' as userList;
import 'cost_tile.dart';


class UserList extends StatelessWidget {
	Widget build(BuildContext context) {
		return userList.Provider(context: context, child: View());
	}
}


class View extends StatelessWidget {

	Widget build(context) {
		final bloc = userList.Provider.of(context);
		bloc.fetch();

		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: createCostTile
		);
	}
}
