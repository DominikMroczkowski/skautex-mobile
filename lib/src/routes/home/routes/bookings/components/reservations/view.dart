import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'bloc/bloc.dart' as userList;
import 'components/tile/tile.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = userList.Provider.of(context);
		bloc.fetch();

		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (reservation) => Tile(reservation: reservation)
		);
	}
}
