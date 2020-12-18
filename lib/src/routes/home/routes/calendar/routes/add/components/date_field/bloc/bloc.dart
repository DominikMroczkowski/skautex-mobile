import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final Function _change;
	DateTime date;
	final Stream stream;

	final hourController = TextEditingController();
	final dayController = TextEditingController();

	Bloc({change, this.date, this.stream, DateTime init}):
		_change = change {
			if (init != null)
				changeDate(init);
		}

	changeDate(DateTime date) async {
		final days = DateFormat.yMMMd().format(date);
		final hours = DateFormat.Hm().format(date);
		dayController.text = days;
		hourController.text = hours;
		this.date = date;
		_change(date);
	}

	changeTime(TimeOfDay time) async {
		date = DateTime(date.year, date.month, date.day, time.hour, time.minute);
		final days = DateFormat.yMMMd().format(date);
		final hours = DateFormat.Hm().format(date);
		dayController.text = days;
		hourController.text = hours;
		this.date = date;
		_change(date);
	}


}
