import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class SupplierOrdersScreen extends StatelessWidget {
  const SupplierOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () {
            Modular.to.navigate('/dashboard/fournisseur/');
          },
          tooltip: 'Retour',
          constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
        ),
        title: Text(
          'Commandes & transactions',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D3748),
          ),
        ),
      ),
      body: const Center(
        child: Text('Écran des commandes et transactions'),
      ),
    );
  }
}