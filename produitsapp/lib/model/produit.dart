class Produit {
  String? id;
  String? libelle;
  String? description;
  double? prix;
  String? photo;

  Produit({
    this.id,
    this.libelle,
    this.description,
    this.prix,
    this.photo,
  });

  // Factory constructor for creating a Produit from JSON
  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      id: json['id'] as String?,
      libelle: json['libelle'] as String?,
      description: json['description'] as String?,
      prix: json['prix'] != null ? (json['prix'] as num).toDouble() : null,
      photo: json['photo'] as String?,
    );
  }

  // Method to convert Produit to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle': libelle,
      'description': description,
      'prix': prix,
      'photo': photo,
    };
  }

  // Copy method for creating a copy of the product
  Produit copyWith({
    String? id,
    String? libelle,
    String? description,
    double? prix,
    String? photo,
  }) {
    return Produit(
      id: id ?? this.id,
      libelle: libelle ?? this.libelle,
      description: description ?? this.description,
      prix: prix ?? this.prix,
      photo: photo ?? this.photo,
    );
  }

  @override
  String toString() {
    return 'Produit(id: $id, libelle: $libelle, description: $description, prix: $prix, photo: $photo)';
  }
}
