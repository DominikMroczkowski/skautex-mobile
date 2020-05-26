class Player {
	String uri;
	String name;
	String surname;
	String position;
	String birthDate;
	String country;
	String city;
	String status;
	String team;
	String league;

	Player({String name, String surname, String position, String birthDate, String country, String city, String status, String team, String league}) :
		name = name,
		surname = surname,
		position = position,
		birthDate = birthDate,
		country = country,
		city = city,
		status = status,
		team = team,
		league = league;

	Player.fromJson(Map<String, dynamic> parsedJson) :
		uri       = parsedJson['url'],
		name      = parsedJson['name'],
    surname   = parsedJson['surname'],
    position  = parsedJson['position'],
    birthDate = parsedJson['birth_date'],
    country   = parsedJson['country'],
    city      = parsedJson['city'],
    status    = parsedJson['status']['name'],
    team      = parsedJson['team']['name'],
    league    = parsedJson['league']['name'];

	toJson() {
		return {
			'name' : name,
			'surname' : surname,
			'position' : position,
			'birth_date' : birthDate,
			'country' : country,
			'city' : city,
			'status' : 'This shouldn\'t even be here. Do you hear me majster?',
			'team' : team,
			'league' : league
		};
	}
}
