import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'bloc/bloc.dart';
import 'components/tile/tile.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/bloc/bloc.dart' as bookingBloc;

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);

		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: (booking) => ItemTile(booking: booking, update: bookingBloc.Provider.of(context).reloadItems)
		);
	}
}
