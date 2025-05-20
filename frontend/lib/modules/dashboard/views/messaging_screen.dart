import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final List<Map<String, dynamic>> conversations = [
    {
      'contact': 'Fournisseur A',
      'lastMessage': 'Bonjour, avez-vous reçu ma proposition ?',
      'time': 'Il y a 1h',
      'unreadCount': 2,
      'avatarColor': const Color(0xFF6C63FF),
    },
    {
      'contact': 'Fournisseur B',
      'lastMessage': 'Merci pour votre commande !',
      'time': 'Il y a 3h',
      'unreadCount': 0,
      'avatarColor': const Color(0xFF32D74B),
    },
    {
      'contact': 'Support Logistique',
      'lastMessage': 'Votre colis est en transit.',
      'time': 'Hier',
      'unreadCount': 1,
      'avatarColor': const Color(0xFFE53E3E),
    },
  ];

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
          'Messagerie Interne',
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
            icon: const Icon(Icons.search, color: Color(0xFF2D3748)),
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
              'Conversations',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  final conversation = conversations[index];
                  return _buildConversationCard(
                    contact: conversation['contact'],
                    lastMessage: conversation['lastMessage'],
                    time: conversation['time'],
                    unreadCount: conversation['unreadCount'],
                    avatarColor: conversation['avatarColor'],
                    isDesktop: isDesktop,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.message_outlined, color: Colors.white),
      ),
    );
  }

  Widget _buildConversationCard({
    required String contact,
    required String lastMessage,
    required String time,
    required int unreadCount,
    required Color avatarColor,
    required bool isDesktop,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: unreadCount > 0 ? const Color(0xFFF7F9FC) : Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: avatarColor.withOpacity(0.1),
          child: Text(
            contact[0],
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: avatarColor,
            ),
          ),
        ),
        title: Text(
          contact,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
            color: const Color(0xFF2D3748),
          ),
        ),
        subtitle: Text(
          lastMessage,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: const Color(0xFF718096),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: const Color(0xFF718096),
              ),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFE53E3E),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unreadCount.toString(),
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          // Naviguer vers un écran de chat détaillé (à implémenter si nécessaire)
        },
      ),
    );
  }
}