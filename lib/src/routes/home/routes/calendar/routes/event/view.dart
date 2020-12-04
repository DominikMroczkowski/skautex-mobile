import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'package:skautex_mobile/src/helpers/others/event_colors.dart';
import 'bloc/bloc.dart';

import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendarBloc;

import 'components/connected_users/connected_users.dart';
import 'components/delete/delete.dart';
import 'components/edit.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);
		return Scaffold(
			appBar: AppBar(
				title: Text(bloc.event.name),
				actions: [
					Delete(event: bloc.event),
					Edit(event: bloc.event, navigator: calendarBloc.Provider.of(context).navigator)
				],
				shadowColor: HexColor(bloc.event.color),
			),
			body: _body(context),
		);
	}

	Widget _body(BuildContext context) {
		return SizedBox.expand(child: Container(
			child: SingleChildScrollView(child: _layout(context))
		,));
	}

	Widget _layout(BuildContext context) {
		final bloc = Provider.of(context);
		return Column(
			children: [
				Container(child:
					_info(bloc.event),
					padding: EdgeInsets.all(8.0)),
				ConnectedUsers(event: bloc.event)
			],
		);
	}


	Widget _info(Event event) {
		return Column(
			children: [
				_disabledField('Nazwa', event.name),
				_disabledField('Opis', event.description),
				_disabledField('Typ', event.type.name),
				_disabledField('Start', event.startDate.toString()),
				_disabledField('Koniec', event.startDate.toString()),
				_disabledField('Twórca', event.owner.nameString()),
			],
		);
	}

	Widget _disabledField(String label, String text) {
		return TextFormField(
			initialValue: text,
			enabled: false,
		  keyboardType: TextInputType.multiline,
		  maxLines: null,
		  decoration: new InputDecoration(
				labelText: label
			)
		);
	}
}

