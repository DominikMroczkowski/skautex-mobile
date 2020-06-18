import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart' as models;
import 'package:skautex_mobile/src/models/permissions.dart' as models;
import 'package:skautex_mobile/src/models/player_report.dart' as models;

import 'package:skautex_mobile/src/blocs/report/bloc.dart' as report;

import 'package:skautex_mobile/src/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/widgets/view_item_list.dart';

class Report extends StatelessWidget {
	build(context) {
		final r = report.Provider.of(context);
		r.fetchLastClicked();

		List<Widget> children = [
			_info(context),
			_header('Zawodnicy'),
			_players(context)
		];

		return Scaffold(
			appBar: AppBar(
				title: Text('Raport')
			),

			body: SizedBox.expand(
				child: Container(
					child: SingleChildScrollView(
						child: Column(
							children: children
						),
					),
					padding: EdgeInsets.all(5),
					color: Colors.white
				)
			),
		);
	}

	Widget _info(BuildContext context) {
		final r = report.Provider.of(context);
		return StreamBuilder(
			stream: r.report.item,
			builder: (context, snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, AsyncSnapshot<models.Report> snapshot) {
							if (snapshot.hasData)
								return _infoBody(snapshot.data);
							return CircularIndicator.color(Colors.blue);
						}
					);
					return CircularIndicator.color(Colors.blue);
			}
		);
	}

	Widget _infoBody(models.Report report) {
		return ViewItemList([
			['Tytuł', report.title],
			['Opis', report.description],
			['Twórca', report.owner],
			['Data zamknięcia', report.closeDate],
		]);
	}

	Widget _players(BuildContext context) {
		final r = report.Provider.of(context);

		return StreamBuilder(
			stream: r.playerReports.watcher,
			builder: (context, AsyncSnapshot<Future<List<models.PlayerReport>>> snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, AsyncSnapshot<List<models.PlayerReport>> snapshot) {
							List<Widget> list = [];
							if (snapshot.hasData) {
								print(snapshot.data);
								snapshot.data.forEach(
									(i) {
										list.add(_playerReport(i));
								});
							}
							if (list.isEmpty)
								list.add(Center(child: Text('Brak zawodników')));
							return Column(
								children: list
							);
						}
					);
				return CircularIndicator.horizontal(Colors.blue);
			}
		);
	}

	_playerReport(models.PlayerReport report) {
		return Card(
			child: ExpansionTile(
				title: Text(report.player),
				children: _playerReportList(report)
			)
		);
	}

	List<Widget> _playerReportList(models.PlayerReport report, ) {
		return [
			Text('Xd'),
			Text('Xd'),
			Text('Xd'),
			Text('Xd'),
			Text('Xd')
		];
	}

	Widget _header(String text) {
		return _text(text, 20);
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

}
