import 'package:skautex_mobile/src/models/user.dart';

class TOTPDevice {
	String uri;
	User user;
	String name;
	bool confirmed;
	int digits;
	String configUri;


	TOTPDevice({this.uri});

	TOTPDevice.fromJson(Map<String, dynamic> parsedJson) :
		uri = parsedJson['url'],
		user = User(uri: parsedJson['user']),
		name = parsedJson['name'] ?? '',
		confirmed = parsedJson['confirmed'] ?? false,
		digits = parsedJson['digits'] ?? 0,
		configUri = parsedJson['config_url'];
}
