import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

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
          'Documents & Factures',
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
              'Mes documents',
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
                  _buildDocumentCard(
                    title: 'Facture #001',
                    date: '15 Mai 2025',
                    amount: '300 000 FCFA',
                    type: 'Facture',
                    isDesktop: isDesktop,
                  ),
                  const SizedBox(height: 12),
                  _buildDocumentCard(
                    title: 'Contrat Fournisseur B',
                    date: '14 Mai 2025',
                    amount: '1 200 000 FCFA',
                    type: 'Contrat',
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

  Widget _buildDocumentCard({
    required String title,
    required String date,
    required String amount,
    required String type,
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
            Icons.description_outlined,
            color: Color(0xFF6C63FF),
            size: 24,
          ),
        ),
        title: Text(
          title,
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
              'Date: $date',
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
          type,
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