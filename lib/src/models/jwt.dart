class JWT {
	String uri;
	String refresh;
	String access;
	String otpauth;

	JWT(this.refresh, this.access);

	JWT.fromJson(Map<String, dynamic> parsedJson) :
		uri = parsedJson['url'],
		refresh = parsedJson['refresh'],
		access  = parsedJson['access'],
		otpauth = parsedJson['otpauth'] != null ? (parsedJson['otpauth'] as Map<String, dynamic>).values.first.toString() : null;
}
