import 'package:ai_chat_voice/bloc/auth_bloc/auth_bloc.dart';
import 'package:ai_chat_voice/bloc/auth_bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myScreenWidth = MediaQuery.of(context).size.width;
    final myScreenHeight = MediaQuery.of(context).size.height;
    //
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TopPartMenue(),
              Container(
                height: myScreenHeight - (myScreenHeight * 0.38),
                margin: const EdgeInsets.only(top: 40),
                width: myScreenWidth * 0.9,
                child: Column(
                  children: [
//*******************  Name Text Field ***********************
                    TextField(
                      controller: _name,
                      autocorrect: true,
                      enableSuggestions: true,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.lightGreen,
                        ),
                        labelText: "Full Name",
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
//*******************  Email Text Field ***********************
                    TextField(
                      controller: _email,
                      autocorrect: false,
                      enableSuggestions: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.lightGreen,
                        ),
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
//*******************  Password Text Field ***********************
                    TextField(
                      controller: _password,
                      style: const TextStyle(letterSpacing: 2),
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.lightGreen,
                        ),
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 48),
                      width: myScreenWidth,
                      child: RegisterButton(
                        name: _name,
                        email: _email,
                        password: _password,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(const AuthEventGoToLogIn());
                              },
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'I have an account?',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: '  Log-in',
                                      style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopPartMenue extends StatelessWidget {
  const TopPartMenue({super.key});

  @override
  Widget build(BuildContext context) {
    final myScreenWidth = MediaQuery.of(context).size.width;
    final myScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: myScreenHeight * 0.33,
      child: Stack(
        children: [
          Container(
            width: myScreenWidth,
            height: myScreenHeight * 0.37,
            color: const Color(0xFF1d2636),
          ),
          Positioned(
            left: -MediaQuery.of(context).size.width * 0.5,
            top: -MediaQuery.of(context).size.width * 0.5,
            child: Container(
              height: MediaQuery.of(context).size.width * 1.3,
              width: MediaQuery.of(context).size.width * 1.3,
              decoration: const BoxDecoration(
                color: Color(0xFF242e40),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -MediaQuery.of(context).size.width * 0.5,
            top: -MediaQuery.of(context).size.width * 0.6,
            child: Container(
              height: MediaQuery.of(context).size.width * 1.2,
              width: MediaQuery.of(context).size.width * 1.1,
              decoration: const BoxDecoration(
                color: Color(0xFF2c374a),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            //color: Colors.amber,
            height: myScreenHeight * 0.37 - 50,
            margin: EdgeInsets.only(
              left: myScreenWidth * 0.1,
            ),
            padding: const EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomLeft,
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      height: 1.1,
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  TextSpan(
                    text: '\nCreate your account',
                    style: TextStyle(
                      height: 3,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final TextEditingController name, email, password;
  const RegisterButton({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(
              16.0), // Replace this value with the desired padding
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                12.0), // Adjust the value axs per your requirement
          ),
        ),
      ),
      onPressed: () {
        context.read<AuthBloc>().add(AuthEventRegisterWithEmail(
              email.text,
              password.text,
              name.text,
              context,
            ));
      },
      child: const Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
