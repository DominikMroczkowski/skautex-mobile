import 'package:flutter/material.dart';
import 'components/date_field/date_field.dart';
import 'bloc/bloc.dart' as dateForm;

class View extends StatelessWidget{
	final booking;
	final bloc;

	View({@required this.booking, @required this.bloc});

	build(BuildContext context) {
		final reservations = dateForm.Provider.of(context).reservationsDates;
		return SingleChildScrollView(
			child: Column(
				children: <Widget>[
					_startDate(reservations),
					_endDate(reservations),
				],
			)
		);
	}

	Widget _startDate(reservations) {
		return StreamBuilder(
			stream: bloc.startDate,
			builder: (context, snapshot) {
				return DateField(
					change: bloc.changeStartDate,
					name: 'Początek',
					text: snapshot.data,
					reservations: reservations
				);
			}
		);
	}

	Widget _endDate(reservations) {
		return StreamBuilder(
			stream: bloc.score,
			builder: (context, snapshot) {
				return DateField(
					change: bloc.changeEndDate,
					name: 'Koniec',
					text: snapshot.data,
					reservations: reservations
				);
			}
		);
	}
}
