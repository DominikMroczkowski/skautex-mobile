import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/routes/home/routes/reports/routes/report/bloc/bloc.dart' as page;

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final Report report;

	Bloc(BuildContext context, {this.report}) {
		otp = context;
		final reportBloc = page.Provider.of(context);

		item.listen(
			(Future i) {
				i.then((_) {
					reportBloc.updateUpperPage != null ? reportBloc.updateUpperPage(): null;
					Navigator.of(context).pop();
					Navigator.of(context).pop();
				}
				);
			}
		);
	}
}
