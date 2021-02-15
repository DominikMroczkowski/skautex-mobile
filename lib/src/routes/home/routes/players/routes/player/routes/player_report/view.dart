import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart' as models;
import 'bloc/bloc.dart';
import 'package:skautex_mobile/src/routes/home/routes/reports/routes/report/components/player_reports/components/player_report/player_report.dart';

class View extends StatelessWidget {

	Widget build(BuildContext context) {
		final bloc = Provider.of(context);
		return StreamBuilder(
			stream: bloc.report,
			builder: (_,  snapshot) {
				if (snapshot.hasData) {
					return _build(snapshot.data);
				}
				return Text('Brak danych');
			},
		);
	}

	Widget _build(models.PlayerReport report) {
		return Scaffold(
			appBar: AppBar(
					title: Text('Raport dla: '+ report.player.toString()),
			),
			body: _body(report),
		);
	}

	Widget _body(models.PlayerReport report) {
		return SingleChildScrollView(
			child: PlayerReport(playerReport: report, enableEdit: false)
		);
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(8.0)
		);
	}
}
