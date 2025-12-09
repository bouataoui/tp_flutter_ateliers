import 'package:flutter/material.dart';
import 'produit_box.dart';
import 'add_produit_form.dart';
import 'produit_details.dart';
import 'model/produit.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  List<Produit> produits = [];
  List<bool> selections = [];

  void _toggleSelection(int index, bool? value) {
    setState(() {
      selections[index] = value ?? false;
    });
  }

  void _addProduit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProduitForm(
          onSubmit: _saveProduit,
        ),
      ),
    );
  }

  void _saveProduit(Produit produit) {
    setState(() {
      produits.add(produit);
      selections.add(false);
    });
  }

  void _delProduit(int index) {
    setState(() {
      produits.removeAt(index);
      selections.removeAt(index);
    });
  }

  void _deleteSelected() {
    setState(() {
      // Remove products in reverse order to maintain correct indices
      for (int i = produits.length - 1; i >= 0; i--) {
        if (selections[i]) {
          produits.removeAt(i);
          selections.removeAt(i);
        }
      }
    });
  }

  void _viewProduitDetails(Produit produit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProduitDetails(produit: produit),
      ),
    );
  }

  bool get hasSelectedProducts => selections.any((selected) => selected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Produits'),
        actions: [
          if (hasSelectedProducts)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Supprimer la sélection',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmation'),
                    content: const Text(
                        'Voulez-vous supprimer les produits sélectionnés ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Annuler'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _deleteSelected();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Supprimer'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: produits.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 100,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun produit',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Appuyez sur + pour ajouter un produit',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: produits.length,
              itemBuilder: (context, index) {
                return ProduitBox(
                  produit: produits[index],
                  selProduit: selections[index],
                  onChanged: (value) => _toggleSelection(index, value),
                  delProduit: () => _delProduit(index),
                  onTap: () => _viewProduitDetails(produits[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduit,
        tooltip: 'Ajouter un produit',
        child: const Icon(Icons.add),
      ),
    );
  }
}
