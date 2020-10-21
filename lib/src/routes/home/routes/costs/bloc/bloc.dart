import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/models/cost.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

class Bloc {
	final _added = BehaviorSubject<bool>();



	dispose() {
		_added.close();
	}
}
