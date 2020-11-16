import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/models/booking_blacklist.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Delete extends StatelessWidget {
	final BookingBlacklist blacklist;

	Delete({this.blacklist});

	Widget build(BuildContext context) {
		return Provider(
			context: context,
			child: View(blacklist: blacklist),
		);
	}
}

