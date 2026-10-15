import 'Proiection.dart';

abstract class Biglietto {
  static const double prezzoIntero = 9.0;
  static const double supplemento3D = 2.0;

  final Proiection proiezione;
  final String posto;

  const Biglietto(this.proiezione, this.posto);

  double get prezzo;

  @override
  String toString() =>
      '${proiezione.film.titolo} - ${proiezione.orario}, ${proiezione.sala}, posto $posto: €${prezzo.toStringAsFixed(2)}';
}

class BigliettoIntero extends Biglietto {
  const BigliettoIntero(super.proiezione, super.posto);

  @override
  double get prezzo => Biglietto.prezzoIntero + (proiezione.is3D ? Biglietto.supplemento3D : 0);
}

class BigliettoRidotto extends Biglietto {
  const BigliettoRidotto(super.proiezione, super.posto);

  @override
  double get prezzo =>
      Biglietto.prezzoIntero * 0.7 + (proiezione.is3D ? Biglietto.supplemento3D : 0);
}

class BigliettoVip extends Biglietto {
  const BigliettoVip(super.proiezione, super.posto);

  @override
  double get prezzo =>
      Biglietto.prezzoIntero + 6 + (proiezione.is3D ? Biglietto.supplemento3D : 0);
}
