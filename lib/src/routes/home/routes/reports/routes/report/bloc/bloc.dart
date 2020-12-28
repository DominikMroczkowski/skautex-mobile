import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final Function updateUpperPage;

	final _report = BehaviorSubject<Report>();
	Stream<Report> get report =>  _report.stream;
	Function(Report) get changeReport => _report.sink.add;

	final _reloadFiles = BehaviorSubject<bool>();
	reloadFiles() {_reloadFiles.sink.add(true);}
	Stream get files => _reloadFiles.stream;

	final playerReports = ItemList<PlayerReport>();

	update({Report report}) {
		changeReport(report ?? _report.value);
	}

	Bloc(BuildContext context, {Report report, this.updateUpperPage}) {
		playerReports.otp = context;
		changeReport(report);

		final _fetchPlayerReport = StreamTransformer<Report, void>.fromHandlers(
			handleData: (i, sink) {
				playerReports.fetch(uri: i.uri + 'player_reports/');
			}
		);
		_report.transform(_fetchPlayerReport);

		playerReports.fetch(uri: report.uri + 'player_reports/');
	}

	dispose() {
		_reloadFiles.close();
	}
}
