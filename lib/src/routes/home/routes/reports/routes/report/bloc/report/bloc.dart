import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';
import '../session/bloc.dart' as session;

import '../../models/report.dart';
import '../../models/player_report.dart';
import '../mixins/item.dart';
import '../mixins/item_list.dart';

class Bloc {
	final report = Item<Report>();
	final playerReports = ItemList<PlayerReport>();

	final _clicked;

	Bloc(BuildContext context) :
		_clicked = session.Provider.of(context).clicked {
		report.otp = context;
		playerReports.otp = context;
	}

	fetchLastClicked() {
		report.fetchItem(_clicked.value);
		report.item.listen(
			(Future<Report> report) async {
				Report tmp = await report;
				playerReports.fetch(uri: tmp.uri + 'player_reports/');
			}
		);
	}
}
