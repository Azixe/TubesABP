import 'package:flutter/material.dart';
import './widgets/input_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login Page', style: GoogleFonts.poppins(
            fontSize: size * 0.080
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InputWidget(
            hintText: 'Email',
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(
            height: 20,
          ),
          InputWidget(
            hintText: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, 
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 50, 
                vertical: 10
                )
              ),
            onPressed: () {}, 
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                fontSize: 
                size * 0.040,
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

