class User {
	String uri;
	String username;
	String firstName;
	String lastName;
	String email;
	String password;
	bool isActive;
	String groups = "Brak Grupy";

	User({String uri, String username, String firstName, String lastName, String email, bool isActive, String password}) :
		uri       = uri ?? '',
    username  = username ?? '',
		firstName = firstName ?? '',
   	lastName  = lastName ?? '',
   	email     = email ?? '',
   	password  = password ?? '',
   	isActive  = isActive ?? true;


	User.fromJson(Map<String, dynamic> parsedJson) :
		uri       = parsedJson['url'],
    username  = parsedJson['username'],
		firstName = parsedJson['first_name'] ?? '',
   	lastName  = parsedJson['last_name'] ?? '',
   	email     = parsedJson['email'],
   	isActive  = parsedJson['is_active'] ?? false;

	Map<String, dynamic> toJson() {
		return <String, dynamic> {
			'url' : uri,
			'username' : username,
			'firstname' : firstName,
			'lastname' : lastName,
			'email' : email,
			'password' : password
		};
	}

	Map<String, dynamic> toPost() {
		var map = toJson();
		map.remove('url');
		return map;
	}

	List<List<String>> toList() {
		return [
			['Nazwa', username],
			['Imię', firstName],
			['Nazwisko', lastName],
			['Email', email],
			['Aktywny', !isActive ? 'Nie' : 'Tak'],
		];
	}
}
