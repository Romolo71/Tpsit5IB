import 'Biglietto.dart';
import 'Film.dart';
import 'Proiection.dart';
import 'Sala.dart';

class Cinema {
  final List<Sala> sale;
  final List<Proiection> proiezioni;

  Cinema(this.sale, this.proiezioni);

  factory Cinema.lumiere() {
    final sala1 = Sala(1, [for (var i = 1; i <= 10; i++) 'A$i']);
    final sala2 = Sala(2, [for (var i = 1; i <= 10; i++) 'B$i']);
    final falco = const Film('Il ritorno del falco', 'Avventura', 128, 4.2);
    final notte = const Film('Notte a Bologna', 'Commedia', 95, 3.8);
    final orbita = const Film('Orbita zero', 'Fantascienza', 141, null);

    return Cinema(
      [sala1, sala2],
      [
        Proiection(falco, sala1, '18:00', false, ['A1', 'A2']),
        Proiection(falco, sala1, '21:00', true, ['A3']),
        Proiection(notte, sala2, '19:30', false, ['B1', 'B2']),
        Proiection(orbita, sala2, '22:00', true, ['B10']),
      ],
    );
  }

  Future<List<Proiection>> getProgrammazione() async {
    return Future.delayed(const Duration(seconds: 1), () => proiezioni);
  }

  Future<Film> getFilm(String titolo) async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      for (final proiezione in proiezioni) {
        if (proiezione.film.titolo.toLowerCase() == titolo.toLowerCase()) {
          return proiezione.film;
        }
      }
      throw Exception('Il film "$titolo" non è in programmazione.');
    });
  }

  Future<List<String>> getPostiLiberi(Proiection proiezione) async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      _controllaProiezione(proiezione);
      return proiezione.sala.posti
          .where((posto) => !proiezione.postiVenduti.contains(posto))
          .toList();
    });
  }

  Future<Biglietto> acquistaBiglietto({
    required Proiection proiezione,
    required String posto,
    bool ridotto = false,
    bool vip = false,
  }) async {
    return Future.delayed(const Duration(seconds: 1), () {
      _controllaProiezione(proiezione);
      if (!proiezione.sala.posti.contains(posto)) {
        throw Exception('Il posto $posto non esiste in ${proiezione.sala}.');
      }
      if (proiezione.postiVenduti.contains(posto)) {
        throw Exception('Il posto $posto è già occupato.');
      }
      if (vip && !posto.endsWith('1')) {
        throw Exception('Il biglietto VIP dà diritto alla prima fila (posto 1).');
      }

      proiezione.postiVenduti.add(posto);
      if (vip) return BigliettoVip(proiezione, posto);
      if (ridotto) return BigliettoRidotto(proiezione, posto);
      return BigliettoIntero(proiezione, posto);
    });
  }

  Future<List<List<String>>> getPostiLiberiTutte() async {
    return Future.wait(proiezioni.map(getPostiLiberi));
  }

  void _controllaProiezione(Proiection proiezione) {
    if (!proiezioni.contains(proiezione)) {
      throw Exception('La proiezione selezionata non esiste.');
    }
  }
}
