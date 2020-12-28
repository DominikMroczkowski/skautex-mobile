import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/report.dart' as models;

import 'reports.dart';
import 'routes/add_report/add_report.dart';
import 'routes/report/report.dart';

const _route = '/home/reports';

Map<String, MaterialPageRoute> routes(RouteSettings settings) {
	return {
		_route: MaterialPageRoute(
			builder: (_) =>  Reports(),
			settings: settings
		),
		_route + '/report':  MaterialPageRoute(
			builder: (_) =>  Report(report: (settings.arguments as List)[0] as models.Report, updateUpperPage: (settings.arguments as List)[1]),
			settings: settings
		),
		_route + '/addReport': MaterialPageRoute(
			builder: (_) =>  AddReport(updateUpperPage: settings.arguments),
			settings: settings
		)
	};
}
