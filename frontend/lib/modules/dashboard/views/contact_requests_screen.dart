import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactRequestsScreen extends StatelessWidget {
  const ContactRequestsScreen({super.key});

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
          'Mes demandes de contact',
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
              'Demandes en cours',
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
                  _buildRequestCard(
                    supplier: 'Fournisseur A',
                    product: 'Biscuits 500g',
                    date: '15 Mai 2025',
                    status: 'En attente',
                    isDesktop: isDesktop,
                  ),
                  const SizedBox(height: 12),
                  _buildRequestCard(
                    supplier: 'Fournisseur B',
                    product: 'Meubles de bureau',
                    date: '14 Mai 2025',
                    status: 'Acceptée',
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

  Widget _buildRequestCard({
    required String supplier,
    required String product,
    required String date,
    required String status,
    required bool isDesktop,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xFF6C63FF).withOpacity(0.1),
          child: const Icon(
            Icons.contact_mail_outlined,
            color: Color(0xFF6C63FF),
            size: 24,
          ),
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
              'Date: $date',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: const Color(0xFF718096),
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: status == 'En attente' ? const Color(0xFFE53E3E).withOpacity(0.1) : const Color(0xFF32D74B).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: status == 'En attente' ? const Color(0xFFE53E3E) : const Color(0xFF32D74B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}