import 'package:skautex_mobile/src/helpers/others/player_statuses.dart';
import 'package:skautex_mobile/src/helpers/positions.dart';

class Player {
	String uri;
	String name;
	String surname;
	String position;
	String birthDate;
	String country;
	String city;
	String status;
	bool isActive;
	List<String> team;
	List<String> league;

	Player({this.uri, String name, String surname, String position, String birthDate, String country, String city, String status, List<String> team, List<String> league}) :
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
		isActive  = parsedJson['is_active'] ?? true,
    country   = parsedJson['country'] ?? '',
    city      = parsedJson['city'] ?? '',
		status    = parsedJson['status'] ?? '',
    team      = parsedJson['team'] != null ?[parsedJson['team']['name'], parsedJson['team']['url']] : [],
    league    = parsedJson['league'] != null ? [parsedJson['league']['name'], parsedJson['league']['url']] : [];

	toJson() {
		return {
			'url' : uri,
			'name' : name,
			'surname' : surname,
			'position' : position,
			'birth_date' : birthDate,
			'country' : country,
			'city' : city,
			'team' : team.isEmpty ? null : team[1],
			'league' : league.isEmpty ? null : league[1],
			'dominant_leg' : "left",
			'status' : "observation"
		};
	}

	toPost() {
		var i = toJson();
		i.remove('url');
		return i;
	}

	toList() {
		return [
			['Imię', name],
			['Nazwisko', surname],
			['Pozycja', getPolishPosition(position)],
			['Data urodzenia', birthDate],
			['Kraj', country],
			['Miasto', city],
			['Status', getPlayerStatusName(status)],
			['Drużyna', team[0]],
			['Liga', league[0]]
		];
	}

	toString() {
		return name ?? '' + ' ' + surname ?? '';
	}
}
