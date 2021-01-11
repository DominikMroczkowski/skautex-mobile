import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'bloc/bloc.dart';
// This is hour + date picker import 'package:skautex_mobile/src/routes/home/routes/calendar/routes/add/components/date_field/date_field.dart';
import 'components/date_field.dart';
import 'components/choose_user/choose_user.dart';
import 'components/choose_template/choose_template.dart';

class View extends StatelessWidget {

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Dodaj zaproszenie na test'),
			),
			body: _body(context),
			backgroundColor: Colors.white
		);
	}

	Widget _body(BuildContext context) {
		final bloc = Provider.of(context);
		return SingleChildScrollView(
			child: Column(
				children: [
					_padding(_header(bloc)),
					_padding(_treiner(bloc)),
					_padding(_template(bloc)),
					_padding(_startDate(bloc)),
					_padding(_endDate(bloc)),
					_padding(_add(bloc))
				],
			)
		);
	}

	Widget _header(Bloc bloc) {
		return Text(
			'Tworzysz zaprosznie dla ' + bloc.player.toString(),
			softWrap: true,
			style: TextStyle(
				fontSize: 16.0
			)
		);
	}

	Widget _treiner(Bloc bloc) {
		return ChooseUser(change: bloc.changeTrainer);
	}

	Widget _startDate(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.startDate,
			builder: (_, snapshot) {
				return DateField(
					value: snapshot.data,
					change: bloc.changeStartDate,
					name: 'Data rozpoczęcia'
				);
			}
		);
	}

	Widget _endDate(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.endDate,
			builder: (_, snapshot) {
				return DateField(
					value: snapshot.data,
					change: bloc.changeEndDate,
					name: 'Data zakończenia'
				);
			}
		);
	}

	Widget _template(Bloc bloc) {
		return ChooseTemplate(
			change: bloc.changeTemplate
		);
	}

	Widget _add(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.submitValid,
			builder: (_, snapshot) {
				return Row(
					children: [
						Expanded(child: Container()),
						RaisedButton(
							child: _indicator(bloc),
							onPressed: snapshot.hasData && snapshot.data == true ? bloc.addInvitation : null,
						)
					]
				);
			}
		);
	}

	Widget _indicator(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.item,
			builder: (_, snapshot) {
				bool indicator = snapshot.hasData && snapshot.connectionState != ConnectionState.done && !snapshot.hasError;
				return indicator ? CircularIndicator() : Text('Dodaj');
			}
		);
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(8.0)
		);
	}
}

