import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/booking.dart';
import 'package:skautex_mobile/src/models/booking_type.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/bloc/bloc.dart' as booking;

class Bloc extends Add<Booking> {
	final bookingBloc;
	final types = ItemList<BookingType>();
	final _name = BehaviorSubject<String>();
	final _type = BehaviorSubject<BookingType>();

	Function(String) get changeName => _name.sink.add;
	Stream<String>  get name => _name.stream;
	Stream<BookingType>  get type => _type.stream;
	Function(BookingType)  get changeType => _type.sink.add;

	Stream<bool> get submitValid  => Rx.combineLatest([name], (List<Object> _) { return true;});

	add() {
		final _add = Booking(
			name: _name.value,
			type: _type.value
		);

		addItem(_add);
	}

	Bloc(BuildContext context, booking.Bloc bloc):
	 bookingBloc = bloc {
		otp = context;
		types.otp = context;
		types.fetch();

		item.listen(
			(Future<Booking> i) {
				i.then((_) {bookingBloc.reloadItems(true);});
			});
	}

	dispose() {
		_name.close();
		_type.close();
	}
}
