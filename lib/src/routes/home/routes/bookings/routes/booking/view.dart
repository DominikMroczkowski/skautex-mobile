import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/helpers/others/booking_types.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as info;
import 'bloc/bloc.dart';
import 'components/bans/bans.dart';

class View extends StatelessWidget {
	final Booking booking;

	View({this.booking});

	Widget build(context) {
		final u = info.Provider.of(context);

		return Scaffold(
			appBar: AppBar(
				title: Text(booking.name),
			),
			body: _body(context),
		);
	}

	Widget _body(BuildContext context) {
		return Column(
			children: [
				Container(child: _info(context), margin: EdgeInsets.all(8.0)),
				Container(height: 16.0),
				Expanded(child: Bans(booking: booking))
			],
		);
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
