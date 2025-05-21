import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Simon Doe');
  final TextEditingController _emailController = TextEditingController(text: 'simon.doe@example.com');
  final TextEditingController _phoneController = TextEditingController(text: '+229 60 12 34 56');
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
          'Profil & Paramètres',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D3748),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.save, color: Color(0xFF32D74B)),
              onPressed: () {
                setState(() {
                  _isEditing = false;
                });
                // Logique de sauvegarde ici
              },
            ),
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF2D3748)),
            onPressed: () {
              setState(() {
                _isEditing = true;
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
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFF6C63FF).withOpacity(0.1),
                child: const Icon(Icons.person, size: 60, color: Color(0xFF6C63FF)),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Informations personnelles',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileField(
              label: 'Nom complet',
              controller: _nameController,
              isEditing: _isEditing,
            ),
            const SizedBox(height: 12),
            _buildProfileField(
              label: 'Email',
              controller: _emailController,
              isEditing: _isEditing,
            ),
            const SizedBox(height: 12),
            _buildProfileField(
              label: 'Téléphone',
              controller: _phoneController,
              isEditing: _isEditing,
            ),
            const SizedBox(height: 24),
            Text(
              'Paramètres',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              icon: Icons.lock_outline,
              title: 'Sécurité & Mot de passe',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildSettingItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildSettingItem(
              icon: Icons.logout,
              title: 'Déconnexion',
              onTap: () {
                Modular.to.navigate('/auth');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: const Color(0xFF718096),
          ),
        ),
        subtitle: isEditing
            ? TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.montserrat(color: const Color(0xFF718096)),
                ),
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: const Color(0xFF2D3748),
                ),
              )
            : Text(
                controller.text,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: const Color(0xFF2D3748),
                ),
              ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6C63FF), size: 24),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: const Color(0xFF2D3748),
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFF718096)),
        onTap: onTap,
      ),
    );
  }
}