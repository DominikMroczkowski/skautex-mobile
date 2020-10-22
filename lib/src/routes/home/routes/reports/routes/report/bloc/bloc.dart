import 'package:flutter/material.dart';

import 'provider.dart';
export 'provider.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as session;


import 'package:skautex_mobile/src/helpers/blocs/item.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/models/player_report.dart';

import 'package:skautex_mobile/src/helpers/blocs/item.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';


/* The biggest problem which breaks all the conventions
 * is edit_report
 */
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
