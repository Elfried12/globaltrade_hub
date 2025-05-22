import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/modules/auth/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/design_system.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required AuthService authService});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading       = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final auth = Modular.get<AuthService>();
      final response = await auth.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // 1) Stocke le token
      final token = response['accessToken'] as String;
      // TODO: sauvegarde dans SecureStorage ou SharedPreferences

      // 2) Lis le role
      final user = response['user'] as Map<String, dynamic>;
      final role = user['role'] as String;

      // 3) Redirige selon le rôle
      switch (role) {
        case 'BUYER':
          Modular.to.pushReplacementNamed('/dashboard/');
          break;
        case 'SUPPLIER':
          Modular.to.pushReplacementNamed('/dashboard/fournisseur');
          break;
        case 'OWNER':
          Modular.to.pushReplacementNamed('/dashboard/proprietaire');
          break;
        default:
          Modular.to.pushReplacementNamed('/');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // cercle décoratif
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 48),
                    _buildEmailField(),
                    _buildPasswordField(),
                    const SizedBox(height: 24),
                    _buildForgotPassword(),
                    const SizedBox(height: 32),
                    _buildLoginButton(),
                    const SizedBox(height: 24),
                    _buildRegisterLink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
        const SizedBox(height: 32),
        Text(
          'Bon retour parmi nous !',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textPrimaryColor,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Connectez-vous pour accéder à votre espace',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            color: textSecondaryColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: GoogleFonts.plusJakartaSans(fontSize: 15, color: textPrimaryColor),
        decoration: InputDecoration(
          hintText: 'exemple@entreprise.com',
          prefixIcon: Icon(Icons.email_outlined, color: textSecondaryColor, size: 20),
          filled: true,
          fillColor: surfaceColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.5),
          ),
        ),
        validator: (v) {
          if (v == null || v.isEmpty) return 'L\'email est requis';
          if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) return 'Email invalide';
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_passwordVisible,
        style: GoogleFonts.plusJakartaSans(fontSize: 15, color: textPrimaryColor),
        decoration: InputDecoration(
          hintText: 'Votre mot de passe',
          prefixIcon: Icon(Icons.lock_outline, color: textSecondaryColor, size: 20),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: textSecondaryColor,
              size: 20,
            ),
            onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
          ),
          filled: true,
          fillColor: surfaceColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.5),
          ),
        ),
        validator: (v) => (v == null || v.isEmpty) ? 'Le mot de passe est requis' : null,
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: forgot password
        },
        child: Text(
          'Mot de passe oublié ?',
          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: primaryColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 56,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: _isLoading ? null : _submitForm,
        child: Ink(
          decoration: BoxDecoration(
            gradient: primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [ BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 12, offset: Offset(0,4)) ],
          ),
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                : Text(
                    'Se connecter',
                    style: GoogleFonts.plusJakartaSans(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return TextButton(
      onPressed: () => Modular.to.pushReplacementNamed('/register'),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.plusJakartaSans(fontSize: 15),
          children: [
            TextSpan(text: 'Pas encore inscrit ? ', style: TextStyle(color: textSecondaryColor)),
            TextSpan(text: 'Créer un compte', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
