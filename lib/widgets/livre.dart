class Livre {
  String dateCreation;
  String titre;
  String nomAuteur;
  String prenomAuteur;
  String photo;
  String resume;
  String genre;
  String localisation;
  String rayon;
  String commentaire;
  String pret;

  Livre({
    required this.dateCreation,
    required this.titre,
    required this.nomAuteur,
    required this.prenomAuteur,
    required this.photo,
    required this.resume,
    required this.genre,
    required this.localisation,
    required this.rayon,
    required this.commentaire,
    required this.pret,
  });

  factory Livre.fromJson(Map<String, dynamic> json) {
    return Livre(
      dateCreation: json['Date Time création'] ?? '',
      titre: json['Titre'] ?? '',
      nomAuteur: json['Nom Auteur'] ?? '',
      prenomAuteur: json['Prénom Auteur'] ?? '',
      photo: json['Photo'] ?? '',
      resume: json['Résumé'] ?? '',
      genre: json['Genre'] ?? '',
      localisation: json['Localisation'] ?? '',
      rayon: json['Rayon'] ?? '',
      commentaire: json['Commentaire'] ?? '',
      pret: json['Pret'] ?? '',
    );
  }
}
