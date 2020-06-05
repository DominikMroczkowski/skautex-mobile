import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/blocs/edit_player/bloc.dart' as editPlayer;
import 'package:skautex_mobile/src/blocs/info/bloc.dart' as info;
import '../../widgets/homeDrawer.dart';
import 'package:skautex_mobile/src/helpers/positions.dart';
import '../../widgets/circular_indicator.dart';


class EditPlayer extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final i = info.Provider.of(context);
		i.fetchTeams(Object());
		i.fetchLeagues(Object());
		return Scaffold(
			body: body(context),
			appBar: AppBar(
				title: Text('Edytuj Zawodnika')
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
          		_goldenRow('Drużyna', _withAdding(_teamField(context), '/home/team/add', context)),
          		_goldenRow('Liga', _withAdding(_leagueField(context), '/home/league/add', context)),
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

	Widget _withAdding(Widget main, String path, BuildContext context) {
		return Row(
			children: <Widget>[
				Expanded(
					child: main,
				),
				Container(
					padding: EdgeInsets.only(right: 5.0)
				),
				Container(
					width: 40.0,
						child: FlatButton(
						padding: EdgeInsets.all(5.0),
						onPressed: () {
							Navigator.of(context).pushNamed(path);
      			},
      			child: Icon(Icons.add, color: Colors.blue),
					)
				)
			],
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
		final p = editPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.name,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator.color(Colors.blue);
				return TextFormField(
					initialValue: snapshot.data,
					onChanged: p.changeName,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _surnameField(context) {
		final p = editPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.surname,
			builder: (context, snapshot) {
				if (snapshot.data == null)
					return CircularIndicator.color(Colors.blue);
				return TextFormField(
					initialValue: snapshot.data,
					onChanged: p.changeSurname,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _positionField(context) {
		final p = editPlayer.Provider.of(context);

		List<DropdownMenuItem> items = positionInterface.map<DropdownMenuItem<String>>(
							(i) {
								return DropdownMenuItem(
									value: i,
									child: Text(i)
								);
							}
						).toList();

		return StreamBuilder(
			stream: p.position,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator.color(Colors.blue);

				return DropdownButton<String>(
					value: positionInterface[positionRequest.indexOf(snapshot.data)],
					items: items,
					onChanged: (String i) { p.changePosition(positionRequest[positionInterface.indexOf(i)]);},
					underline:
						Container(
       				height: 1,
       				color: Colors.grey[300],
      		)
				);
			}
		);
	}

	Widget _birthDateField(context) {
		final p = editPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.birthData,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator.color(Colors.blue);
				return GestureDetector(
				  onTap: () async {
						DateTime date = await showDatePicker(context: context, firstDate: DateTime.utc(1970, 1, 1), lastDate: DateTime.now(), initialDate: DateTime.utc(2000, 1, 1));
						if (date != null)
							p.changeBithDate(formatDate(date, [yyyy, '-', mm, '-', dd]));
					},
  				child: AbsorbPointer(
    				child: _dateField(context)
  				)
				);
			}
		);
	}

	Widget _dateField(context) {
		final p = editPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.birthData,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator.color(Colors.blue);
				var controller = TextEditingController(text: snapshot.data.toString());
				return TextField(
					controller: controller,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _countryField(context) {
		final p = editPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.country,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator.color(Colors.blue);

				return TextFormField(
					initialValue: snapshot.data,
					onChanged: p.changeCountry,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _cityField(context) {
		final p = editPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.city,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return CircularIndicator.color(Colors.blue);

				return TextFormField(
					initialValue: snapshot.data,
					onChanged: p.changeCity,
					decoration: InputDecoration(
						errorText: snapshot.error
					)
				);
			}
		);
	}


	Widget _teamField(context) {
		final p = editPlayer.Provider.of(context);
		final i = info.Provider.of(context);
		return StreamBuilder(
			stream: p.team,
			builder: (context, choosen) {
				if (!choosen.hasData)
					return CircularIndicator.color(Colors.blue);

				return StreamBuilder(
					stream: i.teams,
					builder: (context, future) {
						if (!future.hasData)
							return CircularIndicator.color(Colors.blue);

						return FutureBuilder(
							future: future.data,
							builder: (context, snapshot) {
								if (!snapshot.hasData)
									return CircularIndicator.color(Colors.blue);

								List<DropdownMenuItem> items = snapshot.data.map<DropdownMenuItem<List<String>>>(
										(List<String> i) {
											return DropdownMenuItem<List<String>>(
												value: i,
												child: Text(i[0])
											);
										}
								).toList();

								final index = items.indexWhere((i) => i.value[0] == choosen.data[0] && i.value[1] == choosen.data[1]);

								return DropdownButton<List<String>>(
									value: items[index].value,
									items: items,
									onChanged: (List<String> i) {p.changeTeam(i);},
									underline:
									Container(
        						height: 1,
        						color: Colors.grey[300],
      						)
								);
							}
						);

					}
				);
			}
		);
	}


	Widget _leagueField(context) {
		final p = editPlayer.Provider.of(context);
		final i = info.Provider.of(context);

		return StreamBuilder(
			stream: p.league,
			builder: (context, choosen) {
				if (!choosen.hasData)
					return CircularIndicator.color(Colors.blue);

				return StreamBuilder(
					stream: i.leagues,
					builder: (context, future) {
						if (!future.hasData)
							return CircularIndicator.color(Colors.blue);

						return FutureBuilder(
							future: future.data,
							builder: (context, snapshot) {
								if (!snapshot.hasData)
									return CircularIndicator.color(Colors.blue);

								List<DropdownMenuItem<List<String>>> items = snapshot.data.map<DropdownMenuItem<List<String>>>(
										(List<String> i) {
											return DropdownMenuItem<List<String>>(
												value: i,
												child: Text(i[0])
											);
										}
								).toList();

								final index = items.indexWhere((i) => i.value[0] == choosen.data[0] && i.value[1] == choosen.data[1]);

								return DropdownButton<List<String>>(
									value: items[index].value,
									items: items,
									onChanged: (List<String> name) {p.changeLeague(name);},
									underline:
									Container(
        						height: 1,
        						color: Colors.grey[300],
      						)
								);
							}
						);
					}
				);
			}
		);
	}

	Widget _submitButton(context) {
		final p = editPlayer.Provider.of(context);

		return StreamBuilder(
			stream: p.submitValid,
			builder: (context, snapshot) {
				return Row(
					children: [
						Expanded(child: Container()),
						RaisedButton(
							onPressed: () { p.updatePlayer(context); },
							child: _indicator(p),
							color: Colors.blue,
						),
						Expanded(child: Container())
					]
				);
			}
		);
	}

	Widget _indicator(editPlayer.Bloc p) {
		return  StreamBuilder(
			stream: p.updatePlayerOutput,
			builder: (context, snapshot) {
				if (!snapshot.hasData)
					return Text('Edytuj');

				return FutureBuilder(
					future: snapshot.data,
					builder: (context, futureSnap) {
						if (futureSnap.connectionState == ConnectionState.waiting)
							return CircularIndicator();
						return Text('Edytuj');
					}
				);
			}
		);
	}
}
