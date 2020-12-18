import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart';

import 'bloc/bloc.dart';

import 'package:skautex_mobile/src/helpers/widgets/circular_indicator.dart';

class View extends StatelessWidget {

	build(context) {
		final bloc = Provider.of(context);

		return StreamBuilder(
			stream: bloc.report,
			builder: (_, AsyncSnapshot<Report> snapshot) {
				return _report(snapshot.data);
			}
		);
	}

	Widget _report(Report report) {
		return report == null ?
			Scaffold(
				appBar: AppBar(
					title: Text('Brak Raportu'),
				),
				body: Container(child:
							CircularIndicator.color(Colors.blue)
				)
			) :
			Scaffold(
				appBar: AppBar(
					title: Text(report.title),
						bottom: TabBar(tabs: <Widget>[
							Tab(icon: Icon(Icons.info)),
							Tab(icon: Icon(Icons.person)),
							Tab(icon: Icon(Icons.file_download))
						],)
				),

				body: Container(
					child: SingleChildScrollView(
						child: _tabBarView(report)
					),
					padding: EdgeInsets.all(8.0),
					color: Colors.white
				),
			);
	}

	Widget _tabBarView(Report report) {
		return TabBarView(
			children: <Widget>[
				_info(report),
				PlayerReports(report: report),
				Files(report: report)
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
		return TextFormField(
			initialValue: text,
			enabled: false,
		  keyboardType: TextInputType.multiline,
		  maxLines: null,
		  decoration: new InputDecoration(
				labelText: label
			)
		);
	}
}
