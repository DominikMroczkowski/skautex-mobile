import 'package:flutter/material.dart';
import 'bloc/bloc.dart';

class View extends StatelessWidget{
	final String name;
	View({this.name});

	Widget build(BuildContext context) {
		final bloc = Provider.of(context);
		return StreamBuilder(
			stream: bloc.stream,
			builder: (_, snapshot) {
				return _widget(
					context, bloc, snapshot.error
				);
			}
		);
	}

	Widget _widget(BuildContext context, Bloc bloc, error) {
		return Row(
			children: [
				Expanded(child: _date(context, bloc, error), flex: 2),
				Expanded(child: _hours(context, bloc, error), flex: 1)
			]
		);
	}

	Widget _date(BuildContext context, bloc, error) {
		final bloc = Provider.of(context);

		return GestureDetector(
		  onTap: () {
				showDatePicker(
					context: context,
					firstDate: DateTime.now(),
					lastDate: DateTime.now().add(Duration(days: 365 * 10)),
					initialDate: DateTime.now(),
				).then((i) {
					if (i != null)
						bloc.changeDate(i);
				});
			},
  		child: AbsorbPointer(
    		child: _dateField(bloc, error)
  		)
		);
	}

	Widget _hours(BuildContext context, Bloc bloc, error) {
		return GestureDetector(
		  onTap: () {
				showTimePicker(
					context: context,
					initialTime: TimeOfDay.now(),
				).then((TimeOfDay i) {
					if (i != null)
						bloc.changeTime(i);
				});
			},
  		child: AbsorbPointer(
    		child: _hoursField(bloc, error)
  		)
		);
	}

	Widget _dateField(Bloc bloc, error) {
		return TextField(
			controller: bloc.dayController,
			decoration: InputDecoration(
				labelText: name,
				errorText: error
			)
		);
	}

	Widget _hoursField(Bloc bloc, error) {
		return TextField(
			controller: bloc.hourController,
			decoration: InputDecoration(
				labelText: name,
				errorText: error
			)
		);
	}
}
