class JWT {
	String refresh;
	String access;

	JWT(String refresh, String access) :
		refresh = refresh,
		access = access;

	JWT.fromJson(Map<String, dynamic> parsedJson) :
		refresh = parsedJson['refresh'],
		access  = parsedJson['access'];
}
