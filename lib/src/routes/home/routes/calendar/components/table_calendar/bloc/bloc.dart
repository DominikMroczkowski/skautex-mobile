import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:table_calendar/table_calendar.dart';
import 'provider.dart';
export 'provider.dart';

import 'package:skautex_mobile/src/routes/home/routes/calendar/bloc/bloc.dart' as calendar;

class Bloc {
	final CalendarController calendarController;

	Bloc(BuildContext context, {@required this.calendarController});
}
