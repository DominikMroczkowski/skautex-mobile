import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/models/report.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<File> {
	final Report report;
	final _tabIndex = BehaviorSubject<int>();
	get changeTabIndex => _tabIndex.sink.add;
	get tabIndex => _tabIndex.stream;

	Bloc(BuildContext context, {this.report}) {
		otp = context;
	}

	dispose() {
		_tabIndex.close();
		super.dispose();
	}
}
