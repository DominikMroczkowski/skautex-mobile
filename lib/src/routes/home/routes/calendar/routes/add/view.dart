import 'package:flutter/material.dart';
import 'bloc/bloc.dart';

import 'components/date_field/date_field.dart';
import 'components/type_dropdown/type_dropdown.dart';

class View extends StatelessWidget {

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Dodaj wydarzenie')
			),
			body: _body(context)
		);
	}

	Widget _body(BuildContext context) {
		final bloc = Provider.of(context);
		return SingleChildScrollView(
			child: Column(
				children: <Widget>[
					_title(bloc),
					_type(bloc),
					_start(bloc),
					_end(bloc)
					/*_type(bloc),
					_owner(context),
					_startDate(context),
					_endDate(context),
					_color(context),
					_invite(context), */
				],
			)
		);
	}

	Widget _title(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.name.stream,
			builder: (_, snapshot) {
				return TextFormField(
					onChanged: bloc.name.change,
					decoration: InputDecoration(
						labelText: 'Tytuł'
					),
				);
			}
		);
	}

	Widget _type(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.type.stream,
			builder: (_, snapshot) {
				return TypeDropdown(
					stream: bloc.types,
					change: bloc.type.change,
					value: snapshot.data
				);
			}
		);
	}

	Widget _start(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.start.stream,
			builder: (_, snapshot) {
				return DateField(
					change: bloc.start.change,
					name: "Data rozpoczęcia",
					date: snapshot.data ?? DateTime.now()
				);
			}
		);
	}

	Widget _end(Bloc bloc) {
		return StreamBuilder(
			stream: bloc.end.stream,
			builder: (_, snapshot) {
				return DateField(
					change: bloc.end.change,
					name: "Data Zakończenia",
					date: snapshot.data ?? DateTime.now()
				);
			}
		);
	}

}
