import 'package:flutter/material.dart';
import 'produits_list.dart';
import 'data/base.dart';
import 'dao/produit_dao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  final database = ProduitsDatabase();
  final produitDAO = ProduitDAO(database);

  runApp(MainApp(produitDAO: produitDAO));
}

class MainApp extends StatelessWidget {
  final ProduitDAO produitDAO;

  const MainApp({super.key, required this.produitDAO});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Produits App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: ProduitsList(produitDAO: produitDAO),
    );
  }
}
