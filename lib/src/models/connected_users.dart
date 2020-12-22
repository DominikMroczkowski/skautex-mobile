import 'package:skautex_mobile/src/models/user.dart';

class ConnectedUser {
	String uri;
	User user;

	ConnectedUser({this.user});

	ConnectedUser.fromJson(Map<String, dynamic> parsedJson) :
		uri = parsedJson['url'],
		user = User.fromJson(parsedJson['user']);
}
