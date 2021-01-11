import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'package:skautex_mobile/src/helpers/others/event_colors.dart';
import 'bloc/bloc.dart';

import 'components/connected_users/connected_users.dart';
import 'components/delete/delete.dart';
import 'components/edit.dart';

class View extends StatelessWidget {

	Widget build(context) {
		final bloc = Provider.of(context);
		return StreamBuilder(
			stream: bloc.event,
			builder: (_, AsyncSnapshot<Event> snapshot) {
				if (snapshot.hasData)
					return Scaffold(
						appBar: AppBar(
							title: Text(snapshot.data.name),
							actions: [
								Delete(event: snapshot.data),
								Edit(event: snapshot.data, eventBloc: bloc)
							],
							shadowColor: HexColor(snapshot.data.color),
						),
						body: _body(snapshot.data),
					);
				return Scaffold(
					body: Center(child: Text('Coś poszło nie tak :('))
				);
			}
		);
	}

	Widget _body(Event event) {
		return SizedBox.expand(child: Container(
			child: SingleChildScrollView(child: _layout(event))
		,));
	}

	Widget _layout(Event event) {
		return Column(
			children: [
				Container(child:
					_info(event),
					padding: EdgeInsets.all(8.0)),
				ConnectedUsers(event: event)
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

