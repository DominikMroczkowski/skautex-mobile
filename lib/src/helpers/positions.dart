List<String> positions = [
  "GOALKEEPER 1",
	"SIDE DEFENDER 2",
	"SIDE DEFENDER 3",
  "CENTRAL DEFENDER 4",
  "CENTRAL DEFENDER 5",
  "DEFENSIVE HELP 6",
  "MIDDLE HELP 8",
  "MIDDLE HELP 10",
  "SIDE HELP 7",
  "SIDE HELP 11",
  "ATTACKER 9"
];

String getPolishPosition(String position) {
	if (!positions.contains(position))
		return position;
	final pl = [
		'Bramkarz 1',
		"Pomoc Boczna 2",
		"Pomoc Boczna 3",
		'Pomoc Środkowa 4',
		'Pomoc Środkowa 5',
		'Pomoc Defensywna 6',
		'Obrona Boczna',
		'Środkowa Pomoc 8',
		'Środkowy Pomoc 10',
		'Boczna Pomoc 7',
		'Boczna Pomoc 10',
		'Napastnik 9'
	];
	return pl[positions.indexOf(position)];
}
