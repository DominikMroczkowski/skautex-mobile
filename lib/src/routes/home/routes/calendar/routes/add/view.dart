import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/event.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'bloc/bloc.dart';

import 'components/date_field/date_field.dart';
import 'components/type_dropdown.dart';
import 'components/users_dropdown.dart';
import 'components/users_chip.dart';
import 'components/color_dropdown.dart';
import 'components/indicator.dart';
import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendarBloc;

class View extends StatelessWidget {
	final Event event;

	View({this.event});

	Widget build(context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(event != null ? 'Edytuj wydarzenie' : 'Dodaj wydarzenie')
			),
			body: _body(context),
		);
	}

	Widget _body(BuildContext context) {
		final bloc = Provider.of(context);
		bloc.item.listen(
			(item) => showDialog(
				context: context,
				builder: (_) =>
					Indicator(
						item: item,
						popOnSuccess: calendarBloc.Provider.of(context).navigator.currentState.pop
					)
				)
		);
		return SingleChildScrollView(
			child: _padding(_layout(bloc))		);
	}

	Widget _padding(Widget body) {
		return Container(
			child: body,
			padding: EdgeInsets.all(8.0)
		);
	}

	Widget _layout(bloc) {
		return Column(
			children: <Widget>[
				_padding(_title(bloc)),
				Row(
					children: [
						Expanded(child: _padding(_type(bloc)), flex: 2),
						Expanded(child: _padding(_color(bloc)), flex: 1),
					]
				),
				_padding(_start(bloc)),
				_padding(_end(bloc)),
				_padding(_users(bloc)),
				_padding(_buttons(bloc))
			],
		);
	}

	Widget _title(bloc) {
		return StreamBuilder(
			stream: bloc.name,
			builder: (_, snapshot) {
				return TextFormField(
					onChanged: bloc.changeName,
					decoration: InputDecoration(
						labelText: 'Tytuł'
					),
					initialValue: event?.name ?? ''
				);
			}
		);
	}

	Widget _type(bloc) {
		return StreamBuilder(
			stream: bloc.type,
			builder: (_, snapshot) {
				return TypeDropdown(
					stream: bloc.types,
					change: bloc.changeType,
					value: snapshot.data
				);
			}
		);
	}

Widget _start(bloc) {
		return DateField(
			change: bloc.changeStart,
			name: "Data rozpoczęcia",
			stream: bloc.start,
			init: event !=null ? DateTime.parse(event.startDate) : null
		);
	}

	Widget _end(bloc) {
		return DateField(
			change: bloc.changeEnd,
			name: "Data Zakończenia",
			stream: bloc.end,
			init: event !=null ? DateTime.parse(event.endDate) : null
		);
	}

	Widget _color(bloc) {
		return StreamBuilder(
			stream: bloc.color,
			builder: (_, snapshot) {
				return ColorDropdown(
					change: bloc.changeColor,
					value: snapshot.data ?? event?.color
				);
			}
		);
	}

	Widget _users(bloc) {
		return StreamBuilder(
			stream: bloc.invited,
			builder: (_, AsyncSnapshot<List<User>> snapshot) {
				return Column(
					children: [
						UsersChip(
							change: bloc.changeInvited,
							value: snapshot.data ??  []
						),
						UsersDropdown(
							stream: event != null ? bloc.invitedReady : bloc.users,
							value: snapshot.data ?? [],
							change: bloc.changeInvited,
						)
					],
				);
			}
		);
	}

	Widget _buttons(bloc) {
		return Row(
			children: [
				Expanded(child: Container()),
				_addButton(bloc)
			],
		);
	}

	_addButton(bloc) {
		return StreamBuilder(
			stream: bloc.submitValid,
			builder: (_, snapshot) {
				return FlatButton(
					child: Text(event != null ? 'Edytuj' : 'Dodaj'),
					onPressed:  snapshot.data != null ? () { bloc.send(); }: null
				);
			},
		);
	}
}
