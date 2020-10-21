import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/bloc/bloc.dart' as session;
import 'package:rxdart/rxdart.dart';
import '../../models/jwt.dart';

class Access {
	BehaviorSubject<Future<JWT>> _otp;

	set otp(BuildContext context) {
		final s = session.Provider.of(context);
		_otp = s.otp;
	}

	get otp => _otp.value;
}
