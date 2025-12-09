import 'package:flutter/material.dart';

class AddProduit extends StatelessWidget {
  const AddProduit({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: const Text('Ajouter un produit'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Nom du produit',
          border: OutlineInputBorder(),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              Navigator.of(context).pop(controller.text);
            }
          },
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}
