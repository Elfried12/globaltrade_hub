// lib/modules/auth/views/register_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/modules/auth/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends StatefulWidget {
  
  final AuthService authService;
  const RegisterView({super.key, required this.authService});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _adresseController = TextEditingController();
  final _pieceIdentiteController = TextEditingController();

  DateTime? _dateNaissance;
  String _selectedRole = 'BUYER';      // BUYER, SUPPLIER ou OWNER
  String? _selectedGender;             // 'M' ou 'F'
  bool _passwordVisible = false;

  // Design System Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF32D74B);
  static const Color backgroundColor = Color(0xFFF7F9FC);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textPrimaryColor = Color(0xFF2D3748);
  static const Color textSecondaryColor = Color(0xFF718096);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C63FF), Color(0xFF00FFFF)],
  );

  // Shadows
  static final List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];

  void _pickDateNaissance() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _dateNaissance = picked);
    }
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dateNaissance == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner votre date de naissance')),
      );
      return;
    }
    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner votre sexe')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final auth = Modular.get<AuthService>();
      await auth.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        date_naissance: _dateNaissance!,
        sexe: _selectedGender!,      // 'M' ou 'F'
        telephone: _telephoneController.text.trim(),
        adresse: _adresseController.text.trim(),
        piece_identite: _pieceIdentiteController.text.trim(),
        role: _selectedRole,         // 'BUYER', 'SUPPLIER' ou 'OWNER'
      );
      
      Modular.to.pushReplacementNamed('/auth/login');

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inscription réussie ! Veuillez vous connecter.')),
        );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telephoneController.dispose();
    _adresseController.dispose();
    _pieceIdentiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 50,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: _buildForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(),
        SizedBox(height: 32),
        _buildProgressIndicator(),
        SizedBox(height: 24),

        // Étape 1
        if (_currentStep == 0) ...[
          _buildField("Nom complet", _nameController,
              prefixIcon: Icons.person_outline, hint: "Entrez votre nom complet"),
          _buildField("Email professionnel", _emailController,
              inputType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              hint: "exemple@entreprise.com",
              validator: (v) {
                if (v == null || v.isEmpty) return 'L\'email est requis';
                if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v))
                  return 'Email invalide';
                return null;
              }),
          _buildPasswordField(),
          _buildGenderDropdown(),  // ← nouveau
        ],

        // Étape 2
        if (_currentStep == 1) ...[
          _buildField("Téléphone", _telephoneController,
              inputType: TextInputType.phone,
              prefixIcon: Icons.phone_outlined,
              hint: "+229 XXXXXXXX",
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8)
              ]),
          _buildField("Adresse professionnelle", _adresseController,
              prefixIcon: Icons.location_on_outlined,
              hint: "Quartier, Ville"),
          _buildDatePicker(),
        ],

        // Étape 3
        if (_currentStep == 2) ...[
          _buildField("Numéro de pièce d'identité", _pieceIdentiteController,
              prefixIcon: Icons.badge_outlined,
              hint: "Numéro IFU ou Carte d'identité"),
          _buildRoleDropdown(),  // inchangé
        ],

        SizedBox(height: 32),
        _buildNavigationButtons(),
        _buildLoginLink(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: softShadow,
          ),
          child: Image.asset('assets/images/gthint.png', height: 80),
        ),
        SizedBox(height: 32),
        Text(
          'Rejoignez GlobalTrade Hub',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28, fontWeight: FontWeight.bold, color: textPrimaryColor,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Votre passerelle vers un commerce sécurisé',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16, color: textSecondaryColor, height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: softShadow,
      ),
      child: Row(
        children: List.generate(3, (index) {
          bool isActive = index <= _currentStep;
          bool isPast = index < _currentStep;
          return Expanded(
            child: Row(
              children: [
                if (index > 0)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        gradient: isActive ? primaryGradient : null,
                        color: isActive ? null : Colors.grey.shade200,
                      ),
                    ),
                  ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isActive ? primaryGradient : null,
                    color: isPast ? primaryColor : Colors.grey.shade200,
                    boxShadow: isActive
                        ? [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 4))]
                        : null,
                  ),
                  child: Center(
                    child: isPast
                        ? Icon(Icons.check, color: Colors.white, size: 16)
                        : Text(
                            '${index + 1}',
                            style: GoogleFonts.plusJakartaSans(
                              color: isActive ? Colors.white : textSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mot de passe', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimaryColor)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: !_passwordVisible,
            style: GoogleFonts.plusJakartaSans(fontSize: 15, color: textPrimaryColor),
            decoration: InputDecoration(
              hintText: '8 caractères minimum',
              prefixIcon: Icon(Icons.lock_outline, color: textSecondaryColor, size: 20),
              suffixIcon: IconButton(
                icon: Icon(_passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: textSecondaryColor),
                onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
              ),
              filled: true,
              fillColor: surfaceColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.5),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Le mot de passe est requis';
              if (v.length < 8) return 'Doit contenir au moins 8 caractères';
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Nouveau dropdown pour le sexe
  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        hint: Text('Sélectionnez votre sexe'),
        items: const [
          DropdownMenuItem(value: 'M', child: Text('Homme')),
          DropdownMenuItem(value: 'F', child: Text('Femme')),
        ],
        onChanged: (v) => setState(() => _selectedGender = v),
        decoration: InputDecoration(
          filled: true,
          fillColor: surfaceColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        validator: (v) => v == null ? 'Champ obligatoire' : null,
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    TextInputType inputType = TextInputType.text,
    IconData? prefixIcon,
    String? hint,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimaryColor)),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            style: GoogleFonts.plusJakartaSans(fontSize: 15, color: textPrimaryColor),
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: textSecondaryColor) : null,
              filled: true,
              fillColor: surfaceColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.5),
              ),
            ),
            validator: validator ?? (v) => v == null || v.isEmpty ? 'Ce champ est requis' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date de naissance', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimaryColor)),
          const SizedBox(height: 8),
          InkWell(
            onTap: _pickDateNaissance,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: softShadow,
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined, color: textSecondaryColor),
                  const SizedBox(width: 12),
                  Text(
                    _dateNaissance == null
                        ? 'Sélectionner une date'
                        : 'Né(e) le ${_dateNaissance!.day}/${_dateNaissance!.month}/${_dateNaissance!.year}',
                    style: GoogleFonts.plusJakartaSans(
                      color: _dateNaissance == null ? textSecondaryColor.withOpacity(0.5) : textPrimaryColor,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded, color: textSecondaryColor.withOpacity(0.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleDropdown() {
    // inchangé
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Type de compte', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimaryColor)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: softShadow,
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedRole,
              items: [
                DropdownMenuItem(
                  value: 'BUYER',
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.shopping_cart_outlined, color: primaryColor, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Text('Acheteur', style: GoogleFonts.plusJakartaSans(fontSize: 15, color: textPrimaryColor)),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'SUPPLIER',
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: secondaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.store_outlined, color: secondaryColor, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Text('Fournisseur', style: GoogleFonts.plusJakartaSans(fontSize: 15, color: textPrimaryColor)),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'OWNER',
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: secondaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.local_shipping, color: secondaryColor, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Text('Propriétaire', style: GoogleFonts.plusJakartaSans(fontSize: 15, color: textPrimaryColor)),
                    ],
                  ),
                ),
              ],
              onChanged: (v) => setState(() => _selectedRole = v!),
              decoration: InputDecoration(
                filled: true,
                fillColor: surfaceColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (_currentStep > 0)
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _currentStep--),
              child: Text('Précédent'),
            ),
          ),
        if (_currentStep > 0) const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading
                ? null
                : () {
                    if (_currentStep < 2) setState(() => _currentStep++);
                    else _submitForm();
                  },
            child: _isLoading
                ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : Text(_currentStep < 2 ? 'Suivant' : 'Créer mon compte'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: () => Modular.to.pushReplacementNamed('/auth/login'),
      child: Text("Déjà membre ? Se connecter"),
    );
  }
}
