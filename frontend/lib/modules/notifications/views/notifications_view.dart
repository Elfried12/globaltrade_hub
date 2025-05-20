import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final List<Map<String, dynamic>> notifications = [
    {
      'message': 'Votre demande avec Fournisseur A a été validée.',
      'time': 'Il y a 2 heures',
      'icon': Icons.check_circle_outline,
      'iconColor': const Color(0xFF32D74B),
      'isRead': false,
    },
    {
      'message': 'Réponse attendue sous 48h pour la négociation #123.',
      'time': 'Il y a 5 heures',
      'icon': Icons.hourglass_empty,
      'iconColor': const Color(0xFFE53E3E),
      'isRead': false,
    },
    {
      'message': 'Nouveau message de Fournisseur B.',
      'time': 'Il y a 1 jour',
      'icon': Icons.message_outlined,
      'iconColor': const Color(0xFF6C63FF),
      'isRead': true,
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
          'Notifications',
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
            icon: const Icon(Icons.mark_email_read_outlined, color: Color(0xFF2D3748)),
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification['isRead'] = true;
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Toutes les notifications',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _buildNotificationCard(
                    message: notification['message'],
                    time: notification['time'],
                    icon: notification['icon'],
                    iconColor: notification['iconColor'],
                    isRead: notification['isRead'],
                    isDesktop: isDesktop,
                    onTap: () {
                      setState(() {
                        notification['isRead'] = true;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String message,
    required String time,
    required IconData icon,
    required Color iconColor,
    required bool isRead,
    required bool isDesktop,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isRead ? Colors.white : const Color(0xFFF7F9FC),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [iconColor.withOpacity(0.2), iconColor.withOpacity(0.4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          message,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
            color: const Color(0xFF2D3748),
          ),
        ),
        subtitle: Text(
          time,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: const Color(0xFF718096),
          ),
        ),
        trailing: !isRead
            ? Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFE53E3E),
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}