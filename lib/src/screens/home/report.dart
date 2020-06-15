import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart' as models;
import 'package:skautex_mobile/src/models/permissions.dart' as models;
import 'package:skautex_mobile/src/models/player_report.dart' as models;

import 'package:skautex_mobile/src/blocs/report/bloc.dart' as report;
import 'package:skautex_mobile/src/blocs/info/bloc.dart' as info;

import 'package:skautex_mobile/src/widgets/circular_indicator.dart';
import 'package:skautex_mobile/src/widgets/view_item_list.dart';
import 'package:skautex_mobile/src/widgets/card_body.dart';

class Report extends StatelessWidget {
	build(context) {
		final r = report.Provider.of(context);
		r.fetchLastClicked();

		List<Widget> children = [
			_info(context),
			_players(context)
		];

		return Scaffold(
			appBar: AppBar(
				title: Text('Raport')
			),

			body:
			SingleChildScrollView(
				child: Column(
					children: children
				),
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
		return CardBody(
			children: [
				ViewItemList([
					['Tytuł', report.title],
					['Twórca', report.owner],
					['Data zamknięcia', report.closeDate],
				])
			]
		);
	}

	Widget _players(BuildContext context) {
		final r = report.Provider.of(context);

		return StreamBuilder(
			stream: r.playerReports.item,
			builder: (context, AsyncSnapshot<Future<List<models.PlayerReport>>> snapshot) {
				if (snapshot.hasData)
					return FutureBuilder(
						future: snapshot.data,
						builder: (context, snapshot) {
							return Text('xd');
						}
					);
				return CircularIndicator.horizontal(Colors.blue);
			}
		);
	}
}
