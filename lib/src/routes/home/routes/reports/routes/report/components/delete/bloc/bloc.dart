import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/routes/home/routes/reports/bloc/bloc.dart' as reports;

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final Report report;

	Bloc(BuildContext context, {this.report}) {
		otp = context;
		final reportsBloc = reports.Provider.of(context);

		item.listen(
			(Future i) {
				i.then((_) {
					reportsBloc.reloadReports();
					reportsBloc.navigator.currentState.pop();
				}
				);
			}
		);
	}
}
