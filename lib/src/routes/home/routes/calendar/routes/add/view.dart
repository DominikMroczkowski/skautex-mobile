import 'package:flutter/material.dart';
import 'bloc/bloc.dart';

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
}
