import 'package:flutter/material.dart';
import 'produit_box.dart';
import 'add_produit.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  List<String> produits = [
    'Ordinateur',
    'Téléphone',
    'Tablette',
    'Clavier',
    'Souris',
  ];

  List<bool> selections = [false, false, false, false, false];

  void _toggleSelection(int index, bool? value) {
    setState(() {
      selections[index] = value ?? false;
    });
  }

  void _addProduit() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const AddProduit(),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        produits.add(result);
        selections.add(false);
      });
    }
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
      body: ListView.builder(
        itemCount: produits.length,
        itemBuilder: (context, index) {
          return ProduitBox(
            nomProduit: produits[index],
            selProduit: selections[index],
            onChanged: (value) => _toggleSelection(index, value),
            delProduit: () => _delProduit(index),
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
