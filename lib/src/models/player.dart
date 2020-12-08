class Player {
	String uri;
	String name;
	String surname;
	String position;
	String birthDate;
	String country;
	String city;
	String status;
	List<String> team;
	List<String> league;

	Player({String name, String surname, String position, String birthDate, String country, String city, String status, List<String> team, List<String> league}) :
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
		uri       = parsedJson['url'] ?? '',
		name      = parsedJson['name'] ?? '',
    surname   = parsedJson['surname'] ?? '',
    position  = parsedJson['position'] ?? '',
    birthDate = parsedJson['birth_date'] ?? '',
    country   = parsedJson['country'] ?? '',
    city      = parsedJson['city'] ?? '',
		status    = parsedJson['status'] ?? '',
    team      = [parsedJson['team']['name'], parsedJson['team']['url']],
    league    = [parsedJson['league']['name'], parsedJson['league']['url']];

	toJson() {
		return {
			'name' : name,
			'surname' : surname,
			'position' : position,
			'birth_date' : birthDate,
			'country' : country,
			'city' : city,
			'team' : team[1],
			'league' : league[1],
			'dominant_leg' : 'LEFT',
			'status' : 'OBSERVATION'
		};
	}

	toList() {
		return [
			['Imię', name],
			['Nazwisko', surname],
			['Pozycja', position],
			['Data urodzenia', birthDate],
			['Kraj', country],
			['Miasto', city],
			['Status', status],
			['Drużyna', team[0]],
			['Liga', league[0]]
		];
	}
}
