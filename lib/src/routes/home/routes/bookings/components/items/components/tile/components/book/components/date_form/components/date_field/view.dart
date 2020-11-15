import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skautex_mobile/src/models/booking_reservation.dart';

class View extends StatelessWidget {
	final Function(String) change;
	final String name;
	final String text;
	final Stream reservations;

	View({@required this.change, @required this.name, @required this.text, @required this.reservations});

	Widget build(BuildContext context) {
		return StreamBuilder(
			stream: reservations,
			builder: (_, snapshot) {
				if (snapshot.hasData)
					return _date(context, snapshot.data);
				return loading();
			}
		);
	}

	_findFirst(List<DateTime> reservations) {
		return DateTime.now().subtract(Duration(days: 1));
	}

	Widget _date(BuildContext context, List<DateTime> reservations) {
		print('Reservations ' + reservations.toString());
		final first = _findFirst(reservations);

		return GestureDetector(
		  onTap: () {
				showDatePicker(
					context: context,
					firstDate: first,
					lastDate: first.add(Duration(days: 365 * 10)),
					initialDate: first,
					selectableDayPredicate: (DateTime date) {
						for (int i = 0; i < reservations.length; i++) {
							if (reservations[i].difference(date).inHours.abs() < 23)
								return false;
						}
						return true;
					}
				).then((i) {
					if (i != null)
						change(i.toString());
				});
			},
  		child: AbsorbPointer(
    		child: _dateField()
  		)
		);
	}

	Widget _dateField() {
		var controller = TextEditingController(text: text);
		return TextField(
			controller: controller,
			onChanged: change,
			decoration: InputDecoration(
				labelText: name,
			),
		);
	}

	loading() {
		return Column(
			children: [
				TextField(
					enabled: false,
					decoration: InputDecoration(
						labelText: name,
					),
				),
				LinearProgressIndicator()
			],
		);
	}
}
