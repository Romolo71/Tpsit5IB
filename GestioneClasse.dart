void main() {
  const PRATICO = TipoVoto.PRATICO;
  const SCRITTO = TipoVoto.SCRITTO;
  const ORALE = TipoVoto.ORALE;

  Studente studente = Studente("Pierpaolo", "Zamengo");

  // Aggiunta voti

  print("Studente: ${studente.nome} ${studente.cognome}");

  print("\n--- VOTI INIZIALI ---");

  print("Pratici: ${studente.votiPratici}");
  print("Scritti: ${studente.votiScritti}");
  print("Orali: ${studente.votiOrali}");

  //METODI
  studente.addVoto(10, PRATICO);
  studente.addVoto(10, SCRITTO);
  studente.addVoto(10, ORALE);

  print("\n--- RISULTATI METODI ---");

  print("Pratici: ${studente.votiPratici}");
  print("Scritti: ${studente.votiScritti}");
  print("Orali: ${studente.votiOrali}");

  print("\n--- MEDIE VOTI ---");

  print("Pratici: ${studente.getMedia(PRATICO)}");
  print("Scritti: ${studente.getMedia(SCRITTO)}");
  print("Orali: ${studente.getMedia(ORALE)}");
  // Test rimozione

  studente.rmVoto(10, PRATICO);
  studente.rmVoto(10, SCRITTO);
  studente.rmVoto(10, ORALE);

  print("\n--- DOPO RIMOZIONE ---");

  print("Pratici: ${studente.votiPratici}");
  print("Scritti: ${studente.votiScritti}");
  print("Orali: ${studente.votiOrali}");
}

enum TipoVoto { PRATICO, SCRITTO, ORALE }

class Studente {
  String nome = "";
  String cognome = "";

  List<double> votiPratici = [];
  List<double> votiScritti = [];
  List<double> votiOrali = [];

  Studente(this.nome, this.cognome);

  void addVoto(double voto, TipoVoto type) {
    switch (type) {
      case TipoVoto.PRATICO:
        votiPratici.add(voto);
        break;
      case TipoVoto.SCRITTO:
        votiScritti.add(voto);
        break;
      case TipoVoto.ORALE:
        votiOrali.add(voto);
        break;
    }
  }

  void rmVoto(double voto, TipoVoto type) {
    switch (type) {
      case TipoVoto.PRATICO:
        votiPratici.remove(voto);
        break;
      case TipoVoto.SCRITTO:
        votiScritti.remove(voto);
        break;
      case TipoVoto.ORALE:
        votiOrali.remove(voto);
        break;
    }
  }

  double getMedia(TipoVoto type) {
    double media = 0;
    switch (type) {
      case TipoVoto.PRATICO:
        for (int i = 0; i < votiPratici.length; i++) {
          media += votiPratici[i];
        }
        return (media / votiPratici.length);

      case TipoVoto.SCRITTO:
        for (int i = 0; i < votiScritti.length; i++) {
          media += votiScritti[i];
        }
        return (media / votiScritti.length);
      case TipoVoto.ORALE:
        for (int i = 0; i < votiOrali.length; i++) {
          media += votiOrali[i];
        }
        return (media / votiOrali.length);
    }
  }
}
