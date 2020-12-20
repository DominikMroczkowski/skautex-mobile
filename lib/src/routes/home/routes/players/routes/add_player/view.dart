import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as info;
import 'package:skautex_mobile/src/helpers/positions.dart';
import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'package:date_format/date_format.dart';

import 'bloc/bloc.dart';

class View extends StatelessWidget {
	Widget build(context) {
		final i = info.Provider.of(context);
		i.fetchTeams(Object());
		i.fetchLeagues(Object());

		return Scaffold(
			body: body(context),
			appBar: AppBar(
				title: Text('Dodaj użytkownika')
			),
		);
	}

	Widget body(BuildContext context) {
		return SingleChildScrollView(
			child: Container(
				child: Column (children: <Widget>[
					 _nameField(context),
					_surnameField(context),
    	  	_birthDateField(context),
    	  	_countryField(context),
    	  	_cityField(context),
      		_withAdding(_teamField(context), '/home/team/add', context),
      		_withAdding(_leagueField(context), '/home/league/add', context),
					_positionField(context),
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

	Widget _nameField(context) {
		final p = Provider.of(context);

		return StreamBuilder(
			stream: p.name,
			builder: (context, snapshot) {
				return TextFormField(
					onChanged: p.changeName,
					decoration: InputDecoration(
						labelText: 'Imię',
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _surnameField(context) {
		final p = Provider.of(context);

		return StreamBuilder(
			stream: p.surname,
			builder: (context, snapshot) {
				return TextFormField(
					onChanged: p.changeSurname,
					decoration: InputDecoration(
						labelText: 'Nazwisko',
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _positionField(context) {
		final p = Provider.of(context);

		List<DropdownMenuItem> items = positions.map<DropdownMenuItem<String>>(
			(i) {
				return DropdownMenuItem(
					value: i,
					child: SizedBox(child: Text(i, overflow: TextOverflow.ellipsis)),
				);
			}
		).toList();

		return StreamBuilder(
			stream: p.position,
			builder: (context, snapshot) {
				return DropdownButtonFormField<String>(
					value: snapshot.data,
					items: items,
					isExpanded: true,
					onChanged: (String i) { p.changePosition(i);},
					decoration: InputDecoration(
						labelText: 'Pozycja'
					)
				);
			}
		);
	}

	Widget _birthDateField(context) {
		final p = Provider.of(context);

		return StreamBuilder(
			stream: p.birthData,
			builder: (context, snapshot) {
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
		final p = Provider.of(context);

		return StreamBuilder(
			stream: p.birthData,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					var controller = TextEditingController(text: snapshot.data.toString());
					return TextField(
						controller: controller,
						decoration: InputDecoration(
							labelText: 'Data urodzenia',
							errorText: snapshot.error
						)
					);
				}
				return TextFormField(
					decoration: InputDecoration(
						labelText: 'Data urodzenia',
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _countryField(context) {
		final p = Provider.of(context);

		return StreamBuilder(
			stream: p.country,
			builder: (context, snapshot) {
				return TextField(
					onChanged: p.changeCountry,
					decoration: InputDecoration(
						labelText: 'Kraj',
						errorText: snapshot.error
					)
				);
			}
		);
	}

	Widget _cityField(context) {
		final p = Provider.of(context);

		return StreamBuilder(
			stream: p.city,
			builder: (context, snapshot) {
				return TextField(
					onChanged: p.changeCity,
					decoration: InputDecoration(
						labelText: 'Miasto',
						errorText: snapshot.error
					)
				);
			}
		);
	}


	Widget _teamField(context) {
		final p = Provider.of(context);
		final i = info.Provider.of(context);
		return StreamBuilder(
			stream: p.team,
			builder: (context, choosen) {
				if (choosen.hasData)
					print(choosen.data);
				return StreamBuilder(
					stream: i.teams,
					builder: (context, future) {
						if (future.hasData) {
							return FutureBuilder(
								future: future.data,
								builder: (context, snapshot) {
									if (snapshot.hasData) {
										List<DropdownMenuItem> items = snapshot.data.map<DropdownMenuItem<List<String>>>(
												(List<String> i) {
													return DropdownMenuItem<List<String>>(
														value: i,
														child: Text(i[0])
													);
												}
										).toList();

										int index;
										if (choosen.hasData)
											index = items.indexWhere((i) => i.value[0] == choosen.data[0] && i.value[1] == choosen.data[1]);

										return DropdownButtonFormField<List<String>>(
											value: choosen.hasData ? items[index].value : null,
											items: items,
											onChanged: (List<String> name) {p.changeTeam(name);},
											decoration: InputDecoration(
												labelText: 'Drużyna'
											),
										);
									}
									return Text('Czekam');
								}
							);
						}
						return Text('Czekam');
					}
				);
			}
		);
	}


	Widget _leagueField(context) {
		final p = Provider.of(context);
		final i = info.Provider.of(context);
		return StreamBuilder(
			stream: p.league,
			builder: (context, choosen) {
				return StreamBuilder(
					stream: i.leagues,
					builder: (context, future) {
						if (future.hasData) {
							return FutureBuilder(
								future: future.data,
								builder: (context, snapshot) {
									if (snapshot.hasData) {
										List<DropdownMenuItem> items = snapshot.data.map<DropdownMenuItem<List<String>>>(
												(List<String> i) {
													return DropdownMenuItem<List<String>>(
														value: i,
														child: Text(i[0])
													);
												}
										).toList();

										int index;
										if (choosen.hasData)
											index = items.indexWhere((i) => i.value[0] == choosen.data[0] && i.value[1] == choosen.data[1]);

										return DropdownButtonFormField<List<String>>(
											value: choosen.hasData ? items[index].value : null,
											items: items,
											onChanged: (List<String> name) {p.changeLeague(name);},
											decoration: InputDecoration(
												labelText: 'Liga'
											),
										);
									}
									return Text('Czekam na odpowiedź');
								}
							);
						}
						return Text('Wykonuję zapytanie');
					}
				);
			}
		);
	}

	Widget _submitButton(context) {
		final p = Provider.of(context);

		return StreamBuilder(
			stream: p.submitValid,
			builder: (context, snapshot) {
				return RaisedButton(
					onPressed: p.addPlayer,
					child: _indicator(p),
					color: Colors.blue,
				);
			}
		);
	}

	Widget _indicator(Bloc p) {
		return  StreamBuilder(
			stream: p.item,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, future) {
							if (future.connectionState == ConnectionState.waiting)
								return CircularIndicator();
							return Text('Dodaj');
						}
					);
				}
				return Text('Dodaj');
			}
		);
	}
}
