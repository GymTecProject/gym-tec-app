import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final AuthInterface _authService = DependencyManager.authService;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');


  void onSendEmail() async {
    if (_formKey.currentState!.validate()) {
      bool emailState = await _authService.resetPassword(_emailController.text.trim());
        if (!mounted) return;
      
      if(emailState){
        const resetEmailSnackBar = SnackBar(
          content: Text(
            'Se ha enviado un correo para restablecer su contraseña',
          ),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(resetEmailSnackBar);
        Navigator.of(context).pop();
    }
    else{
      const resetEmailSnackBar = SnackBar(
          content: Text(
            'No se ha encontrado una cuenta con ese correo',
          ),
          duration: Duration(seconds: 3),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(resetEmailSnackBar);
    }
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restablecer contraseña'),
        ),
        body: Form(
          key: _formKey,
          child: ContentPadding(
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su correo electrónico';
                    }
                    if (!_emailRegex.hasMatch(value)) {
                      return 'Por favor ingrese un correo electrónico válido';
                    }
                    return null;
                  },
                ),
                const ContextSeparator(),
                ActionBtn(
                  onPressed: onSendEmail,
                  title: 'Restablecer contraseña',
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ));
  }
}
