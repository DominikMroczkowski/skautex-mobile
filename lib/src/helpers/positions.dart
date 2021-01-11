List<String> positions = [
  "goalkeeper 1",
	"side defender 2",
	"side defender 3",
  "central defender 4",
  "central defender 5",
  "defensive help 6",
  "middle help 8",
  "middle help 10",
  "side help 7",
  "side help 11",
  "attacker 9"
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
		'Środkowa Pomoc 8',
		'Środkowy Pomoc 10',
		'Boczna Pomoc 7',
		'Boczna Pomoc 10',
		'Napastnik 9'
	];
	return pl[positions.indexOf(position)];
}
