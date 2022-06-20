import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../helper/helpers_auth.dart';
import 'package:email_validator/email_validator.dart';

import '../main.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pesquisa Domiciliar',
              textAlign: TextAlign.center,
              style:  TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
              email != null && !EmailValidator.validate(email)
                  ? 'Enter a valid email'
                  : null,
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: senhaController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.trim().length < 6
                  ? 'Enter min. 6 characters'
                  : null,
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: confirmaSenhaController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Confirme a senha'),
              obscureText: true,
              validator: (value) =>
              senhaController.text != confirmaSenhaController.text
                  ? 'Senhas não coincidem'
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.arrow_forward, size: 32),
              label: const Text(
                'Cadastrar',
                style:  TextStyle(fontSize: 24),
              ),
              onPressed: (){
                if(emailController.text.isEmpty || senhaController.text.isEmpty || confirmaSenhaController.text.isEmpty){
                  showMsg('Favor preencher todos os capos para realizar o cadastro.');
                }else{
                  signUp();
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );

  ///Criar um novo entrevistador com email e senha
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: senhaController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      stdout.writeln(e);

      HelpersAuth.showSnackBar(e.message);
    }

    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  ///Mostra um showDialog com menssagem de erro.
  showMsg(String text){
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Questionário Inválido!'),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}