import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/update.dart';
import 'package:skautex_mobile/src/models/player_report.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Update<PlayerReport> {
	final Function update;
	final _report = BehaviorSubject<PlayerReport>();
	get report => _report.stream;

	Bloc(BuildContext context, {this.update, @required PlayerReport report}) {
		_report.sink.add(report);
		otp = context;
	}

	updateReport() {
	}

	Stream<bool> get submitValid  =>
		Rx.combineLatest([], (_) { return true;});

	dispose() {
		_report.close();
		super.dispose();
	}
}
