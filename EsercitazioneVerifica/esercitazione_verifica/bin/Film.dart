class Film {
  final String titolo;
  final String genere;
  final int durata;
  final double? valutazione;

  const Film(this.titolo, this.genere, this.durata, this.valutazione);

  @override
  String toString() =>
      '$titolo - $genere, $durata min, valutazione: ${valutazione ?? "nessuna recensione"}';
}
