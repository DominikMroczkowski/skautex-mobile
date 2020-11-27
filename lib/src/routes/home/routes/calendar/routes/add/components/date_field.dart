import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DateField extends StatelessWidget{
	final Function(DateTime) change;
	final String name;
	final DateTime date;

	DateField({@required this.change, String name, @required this.date}):
		name = name ?? 'Data';

	Widget build(BuildContext context) {
		return Row(
			children: [
				Expanded(child: _date(context), flex: 2),
				Expanded(child: _hours(context), flex: 1)
			]
		);
	}

	Widget _date(BuildContext context) {
		return GestureDetector(
		  onTap: () {
				showDatePicker(
					context: context,
					firstDate: DateTime.now(),
					lastDate: DateTime.now().add(Duration(days: 365 * 10)),
					initialDate: DateTime.now(),
				).then((i) {
					if (i != null)
						change(i);
				});
			},
  		child: AbsorbPointer(
    		child: _dateField()
  		)
		);
	}

	Widget _hours(BuildContext context) {
		return GestureDetector(
		  onTap: () {
				showTimePicker(
					context: context,
					initialTime: TimeOfDay.now(),
				).then((TimeOfDay i) {
					if (i != null)
						change(DateTime(
							date.year, date.month, date.day,
							i.hour, i.minute));
				});
			},
  		child: AbsorbPointer(
    		child: _hoursField()
  		)
		);
	}

	Widget _dateField() {
		final days = DateFormat.yMMMd().format(date);
		return TextField(
			controller: TextEditingController(text: days),
			decoration: InputDecoration(
				labelText: name,
			)
		);
	}

	Widget _hoursField() {
		final hours = DateFormat.Hm().format(date);
		return TextField(
			controller: TextEditingController(text: hours),
			decoration: InputDecoration(
				labelText: "Godzina",
			)
		);
	}
}
