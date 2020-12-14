import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';

import 'components/tile.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (i) => Tile(file: i)
		);
	}
}
