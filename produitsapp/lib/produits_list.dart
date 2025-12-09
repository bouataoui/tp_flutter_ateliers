import 'package:flutter/material.dart';
import 'produit_box.dart';
import 'add_produit_form.dart';
import 'produit_details.dart';
import 'dao/produit_dao.dart';
import 'data/base.dart';

class ProduitsList extends StatelessWidget {
  final ProduitDAO produitDAO;

  const ProduitsList({super.key, required this.produitDAO});

  void _addProduit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProduitForm(produitDAO: produitDAO),
      ),
    );
  }

  void _delProduit(int id) {
    produitDAO.deleteProduit(id);
  }

  void _deleteSelected(BuildContext context, List<int> selectedIds) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Voulez-vous supprimer les produits sélectionnés ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              for (var id in selectedIds) {
                produitDAO.deleteProduit(id);
              }
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
  }

  void _viewProduitDetails(BuildContext context, ProduitsTableData produit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProduitDetails(produit: produit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProduitsTableData>>(
      stream: produitDAO.getAllProduits(),
      builder: (context, snapshot) {
        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Liste des Produits')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // Handle error state
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Liste des Produits')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Erreur: ${snapshot.error}'),
                ],
              ),
            ),
          );
        }

        // Get products from snapshot
        final produits = snapshot.data ?? [];

        return _ProduitsListContent(
          produits: produits,
          produitDAO: produitDAO,
          onAddProduit: () => _addProduit(context),
          onDeleteProduit: _delProduit,
          onDeleteSelected: (selectedIds) =>
              _deleteSelected(context, selectedIds),
          onViewDetails: (produit) => _viewProduitDetails(context, produit),
        );
      },
    );
  }
}

class _ProduitsListContent extends StatefulWidget {
  final List<ProduitsTableData> produits;
  final ProduitDAO produitDAO;
  final VoidCallback onAddProduit;
  final Function(int) onDeleteProduit;
  final Function(List<int>) onDeleteSelected;
  final Function(ProduitsTableData) onViewDetails;

  const _ProduitsListContent({
    required this.produits,
    required this.produitDAO,
    required this.onAddProduit,
    required this.onDeleteProduit,
    required this.onDeleteSelected,
    required this.onViewDetails,
  });

  @override
  State<_ProduitsListContent> createState() => _ProduitsListContentState();
}

class _ProduitsListContentState extends State<_ProduitsListContent> {
  final Set<int> _selectedIds = {};

  void _toggleSelection(int id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  bool get hasSelectedProducts => _selectedIds.isNotEmpty;

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
                widget.onDeleteSelected(_selectedIds.toList());
                setState(() => _selectedIds.clear());
              },
            ),
        ],
      ),
      body: widget.produits.isEmpty
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
              itemCount: widget.produits.length,
              itemBuilder: (context, index) {
                final produit = widget.produits[index];
                return ProduitBox(
                  produit: produit,
                  selProduit: _selectedIds.contains(produit.id),
                  onChanged: (value) => _toggleSelection(produit.id),
                  delProduit: () => widget.onDeleteProduit(produit.id),
                  onTap: () => widget.onViewDetails(produit),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddProduit,
        tooltip: 'Ajouter un produit',
        child: const Icon(Icons.add),
      ),
    );
  }
}
