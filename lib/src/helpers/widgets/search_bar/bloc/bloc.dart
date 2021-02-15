import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	Function change;
	String defaultTitle;

	final _editable = BehaviorSubject<bool>();
	get editable => _editable.stream;

	edit() {
		_editable.sink.add(true);
	}

	final _input = BehaviorSubject<String>();
	get changeInput => _input.sink.add;

	final _title = BehaviorSubject<String>();
	get title => _title.stream;

	Bloc({@required this.change, @required this.defaultTitle}) {
		_title.sink.add(defaultTitle);
	}

	search() {
		_editable.sink.add(false);
		change(_input.value);
	}

	dispose() {
		_input.close();
		_title.close();
	}
}
