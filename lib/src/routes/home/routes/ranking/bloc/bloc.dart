import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Bloc extends ItemList<Report> {
	final GlobalKey<NavigatorState> navigator;

	final _reloadReports = BehaviorSubject<bool>();
	reloadReports() {  _reloadReports.sink.add(true); }

	Bloc(BuildContext context, {this.navigator}) : super(paging: 10) {
		otp = context;
		_reloadReports.listen(
			(_) => fetch()
		);
		super.fetch();
	}

	dispose() {
		_reloadReports.close();
		super.dispose();
	}
}
