import 'package:drift/drift.dart';
import '../data/base.dart';

part 'produit_dao.g.dart';

@DriftAccessor(tables: [ProduitsTable])
class ProduitDAO extends DatabaseAccessor<ProduitsDatabase>
    with _$ProduitDAOMixin {
  final ProduitsDatabase db;

  ProduitDAO(this.db) : super(db);

  // Get all products as a stream (reactive)
  Stream<List<ProduitsTableData>> getAllProduits() {
    return select(produitsTable).watch();
  }

  // Insert a new product
  Future<int> insertProduit(ProduitsTableCompanion produit) {
    return into(produitsTable).insert(produit);
  }

  // Update an existing product
  Future<bool> updateProduit(ProduitsTableCompanion produit) {
    return update(produitsTable).replace(produit);
  }

  // Delete a product by ID
  Future<int> deleteProduit(int id) {
    return (delete(produitsTable)..where((t) => t.id.equals(id))).go();
  }

  // Get a single product by ID
  Future<ProduitsTableData?> getProduitById(int id) {
    return (select(produitsTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }
}
