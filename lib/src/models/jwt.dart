class JWT {
	String refresh;
	String access;

	JWT.fromJson(Map<String, dynamic> parsedJson)
		: refresh = parsedJson['refresh'],
		  access  = parsedJson['access'];
}
