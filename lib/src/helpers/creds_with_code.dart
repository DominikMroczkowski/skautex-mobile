import '../models/jwt.dart';
import 'dart:async';

class CreadsWithCode {
	Future<JWT> jwt;
	String code;

	CreadsWithCode(Future<JWT> jwt, String code) {
		this.jwt = jwt;
		this.code = code;
	}
}
