import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeFAQ extends StatelessWidget {
  const HomeFAQ({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 24.0,
        vertical: 80.0,
      ),
      color: const Color(0xFFEDEFF5),
      child: Column(
        children: [
          Text(
            'Foire Aux Questions',
            style: GoogleFonts.montserrat(
              fontSize: isDesktop ? 42 : 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6C63FF),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Réponses à vos questions les plus fréquentes',
            style: GoogleFonts.montserrat(
              fontSize: isDesktop ? 18 : 16,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _FAQItem(
            question: 'Comment puis-je m\'inscrire ?',
            answer:
                'Visitez la section "Créer un compte" et suivez les étapes simples.',
          ),
          _FAQItem(
            question: 'Quelles sont les méthodes de paiement ?',
            answer:
                'Nous acceptons les paiements par carte, virement bancaire et PayPal.',
          ),
          _FAQItem(
            question: 'Comment contacter le support client ?',
            answer:
                'Vous pouvez nous contacter par email à support@globaltradehub.com ou par téléphone au +1 234 567 890.',
          ),
          _FAQItem(
            question: 'Quels produits sont disponibles ?',
            answer:
                'Nous proposons une large gamme de produits, incluant des biscuits, frites, boissons, meubles, matériaux de construction et produits surgelés.',
          ),
          _FAQItem(
            question: 'Comment suivre ma commande ?',
            answer:
                'Connectez-vous à votre compte et accédez à la section "Mes Commandes" pour suivre l\'état de votre livraison.',
          ),
          _FAQItem(
            question: 'Y a-t-il des frais d\'expédition ?',
            answer:
                'Les frais d\'expédition varient selon la destination et le poids. Consultez les détails lors du checkout.',
          ),
        ],
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: const Color(0xFFFFFFFF),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ExpansionTile(
          title: Text(
            widget.question,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D3748),
            ),
          ),
          onExpansionChanged: (expanded) => setState(() => _isExpanded = expanded),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.answer,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}