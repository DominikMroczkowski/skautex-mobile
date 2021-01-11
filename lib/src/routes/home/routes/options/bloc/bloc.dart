import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final _tab = BehaviorSubject<int>();
	get tab => _tab.stream;
	get changeTab => _tab.sink.add;

	final _reloadTemplates = BehaviorSubject<bool>();
	reloadTemplates() {
		_reloadTemplates.sink.add(true);
	}
	Stream get templates => _reloadTemplates.stream;

	dispose() {
		_tab.close();
	}
}
