import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'package:skautex_mobile/src/models/report.dart';

import 'bloc/bloc.dart';

import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';
import 'components/player_reports/player_reports.dart';
import 'components/files/files.dart';
import 'components/delete/delete.dart';
import 'components/download_raport/download_raport.dart';

import 'components/files/files.dart';
import 'components/player_reports/player_reports.dart';

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
				length: 2,
				child: Scaffold(
					appBar: AppBar(
						title: Text(report.title),
						bottom: TabBar(tabs: <Widget>[
							Tab(icon: Icon(Icons.info)),
							Tab(icon: Icon(Icons.person)),
						],
						),
						actions: [
							DownloadReport(report: report),
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
				return _tabBarView(snapshot.data, report, Provider.of(context));
			}
		);
	}

	Widget _tabBarView(List<PlayerReport> reports, Report report, Bloc bloc) {
		return TabBarView(
			children: <Widget>[
				_info(report, bloc),
				PlayerReports(reports: reports),
			],
		);
	}

	Widget _info(Report report, Bloc bloc) {
		return SingleChildScrollView(
			child: Column(
				children: [
					_disabledField('Tytuł', report.title),
					_disabledField('Opis', report.description),
					_disabledField('Twórca', report.owner),
					_disabledField('Data rozpoczęcia', report.openDate),
					_disabledField('Data zakończenia', report.closeDate),
					_padding(Files(report: report, reload: bloc.files))
				]
			)
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
