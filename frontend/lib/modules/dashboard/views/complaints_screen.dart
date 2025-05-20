import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

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
          'Plaintes & Évaluations',
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
              'Plaintes en cours',
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
                  _buildComplaintCard(
                    complaintId: '#PLT001',
                    supplier: 'Fournisseur A',
                    issue: 'Retard de livraison',
                    status: 'En cours',
                    isDesktop: isDesktop,
                  ),
                  const SizedBox(height: 12),
                  _buildComplaintCard(
                    complaintId: '#PLT002',
                    supplier: 'Fournisseur B',
                    issue: 'Produit défectueux',
                    status: 'Résolue',
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

  Widget _buildComplaintCard({
    required String complaintId,
    required String supplier,
    required String issue,
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
          backgroundColor: const Color(0xFFE53E3E).withOpacity(0.1),
          child: const Icon(
            Icons.report_problem_outlined,
            color: Color(0xFFE53E3E),
            size: 24,
          ),
        ),
        title: Text(
          complaintId,
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
              'Fournisseur: $supplier',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: const Color(0xFF718096),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Problème: $issue',
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
            color: status == 'En cours' ? const Color(0xFFE53E3E).withOpacity(0.1) : const Color(0xFF32D74B).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: status == 'En cours' ? const Color(0xFFE53E3E) : const Color(0xFF32D74B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}