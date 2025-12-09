import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as drift;
import 'dao/produit_dao.dart';
import 'data/base.dart';

class AddProduitForm extends StatefulWidget {
  final ProduitDAO produitDAO;

  const AddProduitForm({super.key, required this.produitDAO});

  @override
  State<AddProduitForm> createState() => _AddProduitFormState();
}

class _AddProduitFormState extends State<AddProduitForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _libelle;
  String? _description;
  double? _prix;
  String? _pickedImagePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _pickedImagePath = image.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la sélection de l\'image: $e')),
        );
      }
    }
  }

  Future<void> _saveProduit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create companion object for database insertion
      final companion = ProduitsTableCompanion.insert(
        libelle: _libelle!,
        description: _description!,
        prix: _prix!,
        photo: drift.Value(_pickedImagePath),
      );

      try {
        await widget.produitDAO.insertProduit(companion);
        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de l\'ajout: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un produit')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Image Picker
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      color: Theme.of(context).primaryColorLight,
                      shape: BoxShape.circle,
                      image: _pickedImagePath != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(_pickedImagePath!)),
                            )
                          : null,
                    ),
                    child: _pickedImagePath == null
                        ? Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Appuyez pour sélectionner une image',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                // Libellé Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Libellé',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir le libellé';
                    }
                    return null;
                  },
                  onSaved: (value) => _libelle = value,
                ),
                const SizedBox(height: 16),
                // Description Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir la description';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value,
                ),
                const SizedBox(height: 16),
                // Prix Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Prix',
                    border: OutlineInputBorder(),
                    suffixText: '€',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir le prix';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Veuillez saisir un nombre valide';
                    }
                    return null;
                  },
                  onSaved: (value) => _prix = double.parse(value!),
                ),
                const SizedBox(height: 24),
                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _formKey.currentState!.reset();
                          setState(() {
                            _pickedImagePath = null;
                          });
                        },
                        icon: const Icon(Icons.restore_from_trash_rounded),
                        label: const Text('Réinitialiser'),
                      ),
                      ElevatedButton(
                        onPressed: _saveProduit,
                        child: const Text('Enregistrer'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
