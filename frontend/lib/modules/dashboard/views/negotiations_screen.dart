import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NegotiationsScreen extends StatelessWidget {
  const NegotiationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2D3748)),
          onPressed: () {
            Modular.to.navigate('/dashboard/');
          },
        ),
        title: Text(
          'Négociations & Transactions',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D3748),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF2D3748)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Négociations en cours',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildNegotiationCard(
                    supplier: 'Fournisseur A',
                    product: 'Biscuits 500g',
                    amount: '300 000 FCFA',
                    status: 'En cours',
                    progress: 0.7,
                    isDesktop: isDesktop,
                  ),
                  const SizedBox(height: 12),
                  _buildNegotiationCard(
                    supplier: 'Fournisseur B',
                    product: 'Meubles de bureau',
                    amount: '1 200 000 FCFA',
                    status: 'Proposition envoyée',
                    progress: 0.4,
                    isDesktop: isDesktop,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildNegotiationCard({
    required String supplier,
    required String product,
    required String amount,
    required String status,
    required double progress,
    required bool isDesktop,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircularPercentIndicator(
          radius: 24,
          lineWidth: 4,
          percent: progress,
          center: Text(
            '${(progress * 100).toInt()}%',
            style: GoogleFonts.montserrat(fontSize: 12),
          ),
          progressColor: const Color(0xFF6C63FF),
          backgroundColor: const Color(0xFFF7F9FC),
        ),
        title: Text(
          supplier,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D3748),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Produit: $product',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: const Color(0xFF718096),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Montant: $amount',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: const Color(0xFF718096),
              ),
            ),
          ],
        ),
        trailing: Text(
          status,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6C63FF),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}