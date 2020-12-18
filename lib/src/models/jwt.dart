class JWT {
	String uri;
	String refresh;
	String access;

	JWT(String refresh, String access) :
		refresh = refresh,
		access = access;

	JWT.fromJson(Map<String, dynamic> parsedJson) :
		uri = parsedJson['url'],
		refresh = parsedJson['refresh'],
		access  = parsedJson['access'];
}
