class User {
	String uri;
	String username;
	String firstName;
	String lastName;
	String email;
	bool isActive;
	String groups = "ToImplement";

	User.fromJson(Map<String, dynamic> parsedJson)
		: uri             = parsedJson['url'],
                  username        = parsedJson['username'],
                  firstName       = parsedJson['first_name'],
                  lastName        = parsedJson['last_name'],
                  email           = parsedJson['email'],
                  isActive        = parsedJson['is_active'] ?? false;
}
