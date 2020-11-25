import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:skautex_mobile/src/models/event_type.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

import 'provider.dart';
export 'provider.dart';

class Types extends ItemList<EventType> {
	Types({context}) {
		otp = context;
		super.fetch();
	}
}
