import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
	final Function(String) change;
	final String name;
	final String value;

	DateField({@required this.change, @required this.name, @required this.value});

	Widget build(BuildContext context) {
		return _date(context);
	}

	Widget _date(BuildContext context) {
		return GestureDetector(
		  onTap: () {
				showDatePicker(
					context: context,
					firstDate: DateTime.now(),
					lastDate: DateTime.now().add(Duration(days: 365 * 10)),
					initialDate: DateTime.now()
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
		var controller = TextEditingController(text: value ?? '');
		return TextField(
			controller: controller,
			onChanged: change,
			decoration: InputDecoration(
				labelText: name,
			),
		);
	}
}
