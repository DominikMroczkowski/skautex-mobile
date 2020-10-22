import 'dart:math';

import 'package:flutter/material.dart';
import 'bloc/bloc.dart' as playerReport;
import 'package:skautex_mobile/src/models/player_report.dart' as models;
import 'package:skautex_mobile/src/models/statistic.dart' as models;

class PlayerReport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
		final playerReportBloc = playerReport.Provider.of(context);
		return _playerReport(playerReportBloc);
  }

	_playerReport(playerReport.Bloc bloc) {
		return StreamBuilder(
			stream: bloc.playerReport,
			builder: (context, snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, AsyncSnapshot<models.PlayerReport> snapshot) {
							if (snapshot.hasData)
								return _playerReportTile(context, snapshot.data);
							return Center(child: CircularProgressIndicator());
						}
					);
				return Center(child: CircularProgressIndicator());
			}
		);
	}

	_playerReportTile(BuildContext context, models.PlayerReport report) {
		return Card(
			child: ExpansionTile(
				title: Row(
					children: [
						Text(report.player),
						Expanded(child: Container()),
						_statusIndicator(report.status)
					]
				),
				children: [Container(
				 child: Column( children: _body(context, report)),
				 padding: EdgeInsets.all(5.0),
				)
				]
			)
		);
	}

	List<Widget> _body(BuildContext context, models.PlayerReport report) {
		List<Widget> list = [];

		int index = 0;
		report.statistics.forEach(
			(i) {
				list.add(
					Column(
						children: [
							_ratingHeader(i, context, index),
							_ratingStars(context, index)
						]
					)
				);
				index += 1;
			}
		);


		list.add(
			_buttonsRow(context)
		);

		return list;
	}

	_buttonsRow(BuildContext context) {
		final playerReportBloc = playerReport.Provider.of(context);

		return StreamBuilder(
			stream: playerReportBloc.isEditable,
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					if (!snapshot.data) {
						return Row(
							children: <Widget>[
								Expanded(child: Container()),
								RaisedButton(
									child: Text('Edytuj'),
									onPressed: playerReportBloc.toggleEdition,
								)
							],
						);
					} else {
						return Row(
							children: <Widget>[
								FlatButton(
									child: Text('Anuluj'),
									onPressed: playerReportBloc.toggleEdition,
								),
								Expanded(child: Container()),
								RaisedButton(
									child: Text('Zapisz'),
									onPressed: () {
										playerReportBloc.update();
										playerReportBloc.toggleEdition();
									}
								)
							],
						);
					}
				}
				return CircularProgressIndicator();
			}
		);
	}

	_ratingHeader(models.Statistic stat, BuildContext context, int index) {
		return Row(
			children: [
			Text(stat.name),
			Expanded(child: Container()),
			_valueOfStat(context, index)
			],
		);
	}

	_valueOfStat(BuildContext context, int index) {
		final playerReportBloc = playerReport.Provider.of(context);

		return StreamBuilder(
			stream: playerReportBloc.statInputs[index].rating,
			builder: (context, AsyncSnapshot<int> snapshot) {
				if (snapshot.hasData)
					return Text(snapshot.data.toString());
				return Text('Brak');
			}
		);
	}

	_ratingStars(BuildContext context, int index) {
		final playerReportBloc = playerReport.Provider.of(context);

		return StreamBuilder(
			stream: playerReportBloc.statInputs[index].rating,
			builder: (context, AsyncSnapshot<int> snapshot) {
				if (snapshot.hasData)
					return StreamBuilder(
						stream: playerReportBloc.isEditable,
						builder: (context, AsyncSnapshot<bool> isEditableSnapshot) {
							if (isEditableSnapshot.hasData)
								if (isEditableSnapshot.data)
									return Slider(
        						onChanged: (i) {
											playerReportBloc.statInputs[index].changeRating(i.toInt());
        					 	},
        					 	max: 10,
										min: 0,
										value: snapshot.data.toDouble(),
    							);
							return Container(height: 0.0, width: 0.0);
						}
					);
				return Container(height: 14.0, color: Colors.grey);
			}
		);
	}

	Widget _statusIndicator(String status) {
		var polish = {
			'TODO' : 'Do zrobienia',
			'CLOSED' : 'Zamknięty',
			'DONE' : 'Zrobiony'
		};

		MaterialColor color;
		if (status == 'TODO')
			color = Colors.red;
		if (status == 'CLOSED')
			color = Colors.green;
		if (status == 'DONE')
			color = Colors.green;

    Widget circle = new Container(
			constraints: new BoxConstraints(
    		minHeight: 10.0,
    		minWidth: 10.0,),
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );

		return Row(children: <Widget>[
			circle,
			Container(padding: EdgeInsets.only(left: 5.0)),
			Text(polish[status])
		]);

	}
}
