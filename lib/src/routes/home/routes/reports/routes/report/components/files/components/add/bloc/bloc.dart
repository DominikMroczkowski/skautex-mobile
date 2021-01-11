import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/upload.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/routes/home/routes/reports/routes/report/bloc/bloc.dart' as bookingBloc;

import 'provider.dart';
export 'provider.dart';

class Bloc extends Upload<File> {
	final Report report;

	final _path = BehaviorSubject<String>();
	Stream<String> get path => _path.stream;
	Function(String) get changePath => _path.sink.add;

	Stream<bool> get submitValid  => Rx.combineLatest([_path.stream], (List<Object> _) { return true;});

	uploadFile() {
		final file = File(
			file: _path.value,
		);

		uploadItem(file);
	}

	Bloc(BuildContext context, {@required this.report}) :
		super(uri: report.uri + 'files/') {
		otp = context;

		final _bookingBloc = bookingBloc.Provider.of(context);

		item.listen(
			(Future<String> i) {
				i.then((_) {_bookingBloc.reloadFiles();});
			}
		);
	}

	dispose() {
		_path.close();
	}
}
