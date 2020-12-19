import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';

import 'bloc/bloc.dart' as addReport;
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/helpers/others/report_type.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class View extends StatelessWidget {

	Widget build(context) {
		return Scaffold(
			body: _body(context),
			appBar: AppBar(
				title: Text('Dodaj raport')
			),
		);
	}

	_body(BuildContext context) {
		return SingleChildScrollView(child: Column(
			children: <Widget>[
				_header('Nowy raport', 22),
				_titleInput(context),
				_descInput(context),
				_header('Obserwowani zawodnicy', 18),
				_observedList(context),
				_observedInput(context),
				_header('Wydarzenie', 18),
				_eventInput(context),
				_typeInput(context),
				_buttons(context)
			].map((i) => _padding(i)).toList()
		));
	}


	_titleInput(BuildContext context) {
		final r = addReport.Provider.of(context);

		return StreamBuilder(
			stream: r.title,
			builder: (context, snapshot) {
				return TextField(
					onChanged: r.changeTitle,
					decoration: InputDecoration(
						hintText: 'Tytuł',
						labelText: 'Tytuł',
						border: new OutlineInputBorder(),
						errorText: snapshot.error
					)
				);
			}
		);
	}

	_descInput(BuildContext context) {
		final r = addReport.Provider.of(context);

		return StreamBuilder(
			stream: r.description,
			builder: (context, snapshot) {
				return TextField(
					maxLines: 3,
					onChanged: r.changeDescription,
					decoration: InputDecoration(
						hintText: 'Opis',
						labelText: 'Opis',
						border: new OutlineInputBorder(),
						errorText: snapshot.error
					)
				);
			}
		);
	}

	_observedList(BuildContext context) {
		final r = addReport.Provider.of(context);

		return StreamBuilder(
			stream: r.choosenPlayers,
			builder: (context, AsyncSnapshot<List<Player>> snapshot) {
				if (snapshot.hasData) {
					List<Widget> children = [];
					snapshot.data.forEach(
						(i) {
							children.add(_player(i, r.deletePlayer));
						}
					);
					return Wrap(
						spacing: 5.0,
						children: children
					);
				}
				return Container(width: 0.0, height: 0.0);
			}
		);
	}

	_observedInput(BuildContext context) {
		final r = addReport.Provider.of(context);

		return StreamBuilder(
			stream: r.players.itemsWatcher,
			builder: (context, AsyncSnapshot<List<Player>> snapshot) {
				List<DropdownMenuItem<Player>> items = [];

				if (snapshot.hasData)
					snapshot.data.forEach(
						(i) =>
							items.add(
								DropdownMenuItem<Player>(
									value: i,
									child: Text(i.toString())
								)
							)
					);

				return SearchableDropdown<Player>(
					items: items,
					onChanged: (Player i) {i != null ?  r.addPlayer(i) : null;},
					isExpanded: true,
					displayClearIcon: false
				);
			}
		);
	}

	_eventInput(BuildContext context) {
		final r = addReport.Provider.of(context);

		return StreamBuilder(
			stream: r.event,
			builder: (context, snapshot) {
				return TextField(
					onChanged: r.changeEvent,
					decoration: InputDecoration(
						hintText: 'Wydarzenie',
						labelText: 'Wydarzenie',
						border: new OutlineInputBorder(),
						errorText: snapshot.error
					)
				);
			}
		);
	}

	_typeInput(BuildContext context) {
		final r = addReport.Provider.of(context);
		List<DropdownMenuItem<String>> items = [];

		reportType.forEach(
			(i) {
				items.add(
					DropdownMenuItem<String>(
						child: Text(i),
						value: i
					)
				);
			}
		);

		return StreamBuilder(
			stream: r.type,
			builder: (context, snapshot) {
				return DropdownButtonFormField<String>(
					items: items,
					value: snapshot.data,
					onChanged: r.changeType,
					decoration: InputDecoration(
						hintText: 'Wybierz typ',
						labelText: 'Typ',
						border: new OutlineInputBorder(),
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _buttons(context) {
		return Row(
			children: [
				Expanded(child: Container()),
				_addButton(context),
				Expanded(child: Container())
			]
		);
	}

	_addButton(BuildContext context) {
		final p = addReport.Provider.of(context);
		return StreamBuilder(
			stream: p.submitValid,
			builder: (context, snapshot) {
				bool submitValid = false;
				if (snapshot.hasData)
					submitValid = true;
				return RaisedButton(
					onPressed: submitValid ? () { p.add(); } : null,
					child: _indicator(p),
					color: Colors.blue,
				);
			}
		);

	}

	Widget _indicator(addReport.Bloc p) {
		return  StreamBuilder(
			stream: p.item,
			builder: (context, AsyncSnapshot<Future<Report>> snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, AsyncSnapshot<Report> snapshot) {
							if (snapshot.hasData || snapshot.hasError)
								return Text('Dodaj');
							return CircularIndicator();
						}
					);
				return Text('Dodaj');
			}
		);
	}

	_header(text, double font, [alignment]) {
		alignment ??= Alignment.centerLeft;
		return Align(
			child: Text(
				text,
				overflow: TextOverflow.fade,
				style: TextStyle(
					fontSize: font,
				)
			),
			alignment: alignment
		);
	}

	_text(text, double font) {
		return Text(
				text,
				overflow: TextOverflow.fade,
				style: TextStyle(
					fontSize: font,
				)
		);
	}


	_player(Player player, Function onDeleted) {
		return Chip(
			label: _text(player.name + ' ' + player.surname, 14),
			deleteIcon: Icon(Icons.clear, size: 14),
			onDeleted: () { onDeleted(player);}
		);
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(8.0)
		);
	}
}
