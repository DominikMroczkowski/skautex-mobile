import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking.dart';
import 'view.dart';

class DateField extends StatelessWidget{
	final Function(String) change;
	final String name;
	final String text;
	final Stream reservations;

	DateField({@required this.change, String name, @required this.text, @required this.reservations}):
		name = name ?? 'Data';

	Widget build(BuildContext context) {
		return View(
			 change: change,
			 name: name,
			 text: text,
			 reservations: reservations
		);
	}
}
