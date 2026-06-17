import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  void login() async {
    bool ok = await ApiService.login(
      emailCtrl.text,
      passCtrl.text,
    );

    if (ok) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("LOGIN", style: TextStyle(fontSize: 30)),
              TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
              TextField(controller: passCtrl, obscureText: true, decoration: InputDecoration(labelText: "Password")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: login, child: Text("Ingresar")),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text("Ir a Registro"),
              )
            ],
          ),
        ),
      ),
    );
  }
}