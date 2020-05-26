import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/positions.dart';
import '../../widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/blocs/add_player/bloc.dart' as addPlayer;
import '../../widgets/circular_indicator.dart';

class AddPlayer extends StatelessWidget {

	Widget build(context) {
		return Scaffold(
			body: body(context),
			appBar: AppBar(
				title: Text('Dodaj użytkownika')
			),
			drawer: HomeDrawer(),
		);
	}

	Widget body(BuildContext context) {
		return Container(
			child: Card(
				child: SingleChildScrollView(
					child: Container(
						child: Column (children: <Widget>[
							_goldenRow('Imię', _nameField(context)),
							_goldenRow('Nazwisko', _surnameField(context)),
        	  	_goldenRow('Data urodzenia', _birthDateField(context)),
        	  	_goldenRow('Kraj', _countryField(context)),
        	  	_goldenRow('Miasto', _cityField(context)),
          		_goldenRow('Drużyna', _teamField(context)),
          		_goldenRow('Liga', _leagueField(context)),
							_goldenRow('Pozycja', _positionField(context)),
							Container(
								constraints: BoxConstraints(
									maxHeight: 50.0
								),
							),
							_submitButton(context)
							],
						),
						padding: EdgeInsets.all(15.0),
					),
				)
			),
			margin: EdgeInsets.all(15.0),
		);
	}

	Widget _goldenRow(String name, Widget field) {
		return Container(
			height: 50.0,
			child: Row(
				children: <Widget>[
					Expanded(
						flex: 21,
						child: _header(name),
					),
					Container(
						padding: EdgeInsets.only(left: 10)
					),
					Expanded(
						flex: 34,
						child: field,
					)
				],
			)
		);
	}

	Widget _header(String name) {
		return Align(
			alignment: Alignment.centerRight,
			child: Text(
				name,
				style: TextStyle(
						fontSize: 16
				)
			)
		);
	}

	Widget _nameField(context) {
		final p = addPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.name,
			builder: (context, snapshot) {
				return TextField(
					onChanged: p.changeName,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _surnameField(context) {
		final p = addPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.surname,
			builder: (context, snapshot) {
				return TextField(
					onChanged: p.changeSurname,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _positionField(context) {
		final p = addPlayer.Provider.of(context);

		List<DropdownMenuItem> items = Positions.values.map<DropdownMenuItem<String>>(
							(i) {
								return DropdownMenuItem(
									value: positionsNames[i.index],
									child: Text(positionsNames[i.index])
								);
							}
						).toList();

		return StreamBuilder(
			stream: p.position,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return DropdownButton<String>(
						value: positionsNames[Positions.values.indexOf(snapshot.data)],
						items: items,
						onChanged: (String i) { p.changePosition(Positions.values[positionsNames.indexOf(i)]);},
						underline:
							Container(
        				height: 2,
        				color: Colors.grey[300],
      				)
					);
				}
				return DropdownButton<String>(
						value: '3wa',
						items: items,
						onChanged: (String i) { p.changePosition(Positions.values[positionsNames.indexOf(i)]);},
						underline:
								Container(
        					height: 2,
        					color: Colors.grey[300],
      					)
					);
			}
		);
	}

	Widget _birthDateField(context) {
		final p = addPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.birthData,
			builder: (context, snapshot) {
				return GestureDetector(
				  onTap: () async {
						DateTime date = await showDatePicker(context: context, firstDate: DateTime.utc(1989, 11, 9), lastDate: DateTime.now(), initialDate: DateTime.now());
						if (date != null)
							p.changeBithDate(date);
					},
  				child: AbsorbPointer(
    				child: _dateField(context)
  				)
				);
			}
		);
	}

	Widget _dateField(context) {
		final p = addPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.birthData,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					var controller = TextEditingController(text: snapshot.data.toString());
					return TextField(
						controller: controller,
						decoration: InputDecoration(
							errorText: snapshot.error
						)
					);
				}
				return TextField(
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _countryField(context) {
		final p = addPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.country,
			builder: (context, snapshot) {
				return TextField(
					onChanged: p.changeCountry,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _cityField(context) {
		final p = addPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.city,
			builder: (context, snapshot) {
				return TextField(
					onChanged: p.changeCountry,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _teamField(context) {
		final p = addPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.team,
			builder: (context, snapshot) {
				return TextField(
					onChanged: p.changeTeam,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _leagueField(context) {
		final p = addPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.league,
			builder: (context, snapshot) {
				return TextField(
					onChanged: p.changeLeague,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _submitButton(context) {
		final p = addPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.submitValid,
			builder: (context, snapshot) {
				return RaisedButton(
					onPressed: () {p.submitPlayer(Object());},
					child: _indicator(p),
					color: Colors.blue,
				);
			}
		);
	}

	Widget _indicator(p) {
		return  StreamBuilder(
			stream: p.response,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							if (!snapshot.hasData && !snapshot.hasError) {
								return CircularIndicator();
							}
							return Text('Dodaj');
						}
					);
				}
				return Text('Dodaj');
			}
		);
	}
}
