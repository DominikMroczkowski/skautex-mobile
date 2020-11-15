import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'view.dart';
import 'package:skautex_mobile/src/routes/home/routes/bookings/bloc/bloc.dart' as booking;

class AddDialog extends StatelessWidget {
	final booking.Bloc bloc;
	AddDialog({this.bloc});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(),
			bloc: bloc
		);
	}
}
