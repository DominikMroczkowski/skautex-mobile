import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/header.dart';
import 'package:skautex_mobile/src/models/player_report.dart' as models;

import 'bloc/bloc.dart';
import 'components/statistic_field.dart';

class View extends StatelessWidget {
	final bool enableEdit;

	View({this.enableEdit = true});

  Widget build(BuildContext context) {
		final bloc = Provider.of(context);
		return _padding(
			StreamBuilder(
				stream: bloc.playerReport,
				builder: (context, snapshot) {
					return _build(context, snapshot.data);
				},
			)
		);
	}

  Widget _build(BuildContext context, models.PlayerReport report) {
		final bloc = Provider.of(context);
		if (report == null)
			return Center(child: Text('Brak raportu zawodnika'));
		return _playerReport(bloc, report);
  }

	_playerReport(Bloc bloc, models.PlayerReport report) {
		return StreamBuilder(

			stream: bloc.edit,
			builder: (_,snapshot) {
				bool isEditable = true;
				if (snapshot.data == null)
					isEditable = false;
				else
					isEditable = snapshot.data;

				return SingleChildScrollView(
					child: Column(
						children: [
							_info(bloc, report, isEditable),
							_padding(_mainDescription(report, bloc, isEditable)),
							_statistics(bloc, report, isEditable)
						],
					)
				);
			}
		);
	}

	Widget _info(Bloc bloc, models.PlayerReport report, bool isEditable) {
		return Row( children: [
			Header(text: 'Raport dla: ' + report.player.toString()),
			_editButton(bloc, isEditable)
		]);
	}

	Widget _editButton(Bloc bloc, bool isEditable) {
		if (!isEditable && enableEdit)
			return _padding(
				FlatButton(
					child: Text("Edytuj"),
					onPressed: bloc.toggleEdition
				)
			);
		return Container(width: 0.0, height: 0.0);
	}

	Widget _mainDescription(models.PlayerReport report, Bloc bloc, bool isEditable) {
		return TextFormField(
			initialValue: report.description,
			onChanged: (String s) {
				report.description = s;
				bloc.changePlayerReport(report);
			},
			enabled: isEditable,
			minLines: 1,
			maxLines: 3,
			decoration: InputDecoration(
				labelText: "Opis"
			)
		);
	}

	Widget _statistics(Bloc bloc, models.PlayerReport report, isEditable) {
		List<Widget> list = [];

		int index = 0;
		int profile = 0;
		report.profiles.forEach(
			(i) {
				list.add( Header(text: i.name ?? 'Brak nazwy'));
				list.add(Divider());
				list.add(_padding(_profileDescription(report, bloc, isEditable, profile)));
				i.statistics.forEach(
					(i) {
						list.add(
							_padding(
								StatisticField(
									name: i.name,
									value: i.value ?? 0,
									changeValue: isEditable ? bloc.changePlayerReport : null,
									report: report,
									index: index
								),
							),
						);
						index++;
					}
				);

				i.group.forEach(
					(i) {
						list.add(_padding(Header(text: i.name ?? "Brak nazwy grupy", fontSize: 16)));
						i.statistics.forEach(
							(i) {
								list.add(_padding(
									StatisticField(
										name: i.name,
										value: i.value ?? 0,
										changeValue: isEditable ? bloc.changePlayerReport : null,
										report: report,
										index: index
									))
								);
								index++;
							}
						);
					}
				);
				profile++;
			}
		);

		list.add(
			_buttonsRow(bloc, isEditable)
		);

		return Column(
			children: list,
		);
	}

	Widget _profileDescription(models.PlayerReport report, Bloc bloc, bool isEditable, int index) {
		return TextFormField(
			initialValue: report.profiles[index].description,
			onChanged: (String s) {
				bloc.changePlayerReport(report, description: s, index: index);
			},
			enabled: isEditable,
			minLines: 1,
			maxLines: 3,
			decoration: InputDecoration(
				labelText: "Opis"
			)
		);
	}


	_buttonsRow(Bloc bloc, bool isEditable) {
		if (isEditable)
			return Row(
				children: <Widget>[
					FlatButton(
						child: Text('Anuluj'),
						onPressed: bloc.toggleEdition,
					),
					Expanded(child: Container()),
					RaisedButton(
						child: Text('Zapisz'),
						onPressed: () {
							bloc.update();
						}
					)
				],
			);
		return Container(height: 0.0, width: 0.0);
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(8.0)
		);
	}
}
