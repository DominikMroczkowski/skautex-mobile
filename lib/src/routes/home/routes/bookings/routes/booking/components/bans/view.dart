import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/stream_list.dart';
import 'package:skautex_mobile/src/helpers/others/booking_types.dart';
import 'package:skautex_mobile/src/models/booking_blacklist.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as info;
import 'bloc/bloc.dart';
import 'components/add/add.dart';
import 'components/delete/delete.dart';

class View extends StatelessWidget {
	final Booking booking;

	View({this.booking});

	Widget build(context) {
		final u = info.Provider.of(context);

		return Column(
			children: [
				Container(child: _name(), margin: EdgeInsets.all(8.0),),
				Expanded(child:_banList(context))
			]
		);
	}

	Widget _name() {
		return Row(
			children: [
				Text(
					'Zablokowani użytkownicy:',
					softWrap: true,
				),
				Expanded(child: Container()),
				Add(booking: booking),
			]
		);
	}

	_banList(BuildContext context) {
		final bloc = Provider.of(context);
		return StreamList(
			itemsWatcher: bloc.itemsWatcher,
			requestWatcher: bloc.requestWatcher,
			tile: _tile
		);
	}

	_tile(BookingBlacklist blacklist) {
		return Container(child: Card(
			child: ListTile(
			title: Text(blacklist.user.toString()),
			trailing: Delete(blacklist: blacklist)
		)), padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0));
	}

	Widget _info(BuildContext context) {
		return Column(
			children: [
				_disabledField('Nazwa', booking.name),
				_disabledField('Typ', getBookingTypeName(booking.type.name)),
			],
		);
	}

	Widget _disabledField(String label, String text) {
		return TextFormField(
			initialValue: text,
			enabled: false,
		  keyboardType: TextInputType.multiline,
		  maxLines: null,
		  decoration: new InputDecoration(
				labelText: label
			)
		);
	}
}
