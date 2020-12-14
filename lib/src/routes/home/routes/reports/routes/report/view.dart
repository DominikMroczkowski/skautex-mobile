import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'package:skautex_mobile/src/models/report.dart';

import 'bloc/bloc.dart';

import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'components/player_reports/player_reports.dart';
import 'components/files/files.dart';
import 'components/delete/delete.dart';

class View extends StatelessWidget {

	build(context) {
		final bloc = Provider.of(context);

		return StreamBuilder(
			stream: bloc.report,
			builder: (_, AsyncSnapshot<Report> snapshot) {
				return _report(context, snapshot.data);
			}
		);
	}

	Widget _report(BuildContext context, Report report) {
		final _tabs = TabController(
				length: 3,
				vsync:
			);

		return report == null ?
			Scaffold(
				appBar: AppBar(
					title: Text('Brak Raportu'),
				),
				body: Container(child:
							CircularIndicator.color(Colors.blue)
				)
			) :
			DefaultTabController(
				length: 3,
				child: Scaffold(
					appBar: AppBar(
						title: Text(report.title),
						bottom: TabBar(tabs: <Widget>[
							Tab(icon: Icon(Icons.info)),
							Tab(icon: Icon(Icons.person)),
							Tab(icon: Icon(Icons.file_download))
						],
						),
						actions: [
							Delete(report: report)
						]
					),
					body: _tabBar(context, report)
				)
			);
	}

	Widget _tabBar(BuildContext context, Report report) {
		final bloc = Provider.of(context);
		return StreamBuilder(
			stream: bloc.playerReports.itemsWatcher,
			builder: (_, snapshot) {
				return _tabBarView(snapshot.data, report);
			}
		);
	}

	Widget _tabBarView(List<PlayerReport> reports, Report report) {
		return TabBarView(
			children: <Widget>[
				_info(report),
				PlayerReports(reports: reports),
				Files()
			],
		);
	}

	Widget _info(Report report) {
		return Column(
			children: [
				_disabledField('Tytuł', report.title),
				_disabledField('Opis', report.description),
				_disabledField('Twórca', report.owner),
				_disabledField('Data rozpoczęcia', report.openDate),
				_disabledField('Data zakończenia', report.closeDate),
				_disabledField('Typ', report.type),
			]
		);
	}

	Widget _disabledField(String label, String text) {
		return _padding(TextFormField(
			initialValue: text,
			enabled: false,
		  keyboardType: TextInputType.multiline,
		  maxLines: null,
		  decoration: new InputDecoration(
				labelText: label
			)
		));
	}

	Widget _padding(Widget child) {
		return Container(
			child: child,
			padding: EdgeInsets.all(8.0)
		);
	}

}
