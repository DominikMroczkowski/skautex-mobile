class Player {
	String uri;
	String name;
	String surname;
	String position;
	String birthDate;
	String country;
	String city;
	String profilePicture;
	String team;
	String league;

	Player.fromJson(Map<String, dynamic> parsedJson)
		: uri            = parsedJson['url'],
                  name           = parsedJson['name'],
                  surname       = parsedJson['surname'],
                  position       = parsedJson['position'],
                  birthDate      = parsedJson['birth_date'],
                  country        = parsedJson['country'],
                  city           = parsedJson['city'],
                  profilePicture = parsedJson['profilePicture'],
                  team           = parsedJson['team'],
                  league         = parsedJson['league'];
}
