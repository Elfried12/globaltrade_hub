import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    final products = [
      {'name': 'Biscuits', 'image': 'assets/images/biscuits.png'},
      {'name': 'Frites', 'image': 'assets/images/frites.jpg'},
      {'name': 'Boissons', 'image': 'assets/images/boissons.jpg'},
      {'name': 'Meubles', 'image': 'assets/images/meubles.jpg'},
      {'name': 'Matériaux', 'image': 'assets/images/materiaux.jpg'},
      {'name': 'Produits Surgelés', 'image': 'assets/images/congele.jpg'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 24.0,
        vertical: 80.0,
      ),
      color: const Color(0xFFF5F7FA),
      child: Column(
        children: [
          Text(
            'Nos Produits Phares',
            style: GoogleFonts.montserrat(
              fontSize: isDesktop ? 42 : 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6C63FF),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Explorez la diversité des produits disponibles sur notre plateforme',
            style: GoogleFonts.montserrat(
              fontSize: isDesktop ? 18 : 16,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _ProductCard(
                name: products[index]['name']!,
                image: products[index]['image']!,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String name;
  final String image;

  const _ProductCard({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              name,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}