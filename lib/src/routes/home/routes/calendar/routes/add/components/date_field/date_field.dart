import 'package:flutter/material.dart';
import 'view.dart';

class DateField extends StatelessWidget{
	final Function(DateTime) change;
	final String name;
	final DateTime date;

	DateField({@required this.change, String name, @required this.date}):
		name = name ?? 'Data';

	Widget build(BuildContext context) {
		return View(
			 change: change,
			 name: name,
			 date: date,
		);
	}
}
