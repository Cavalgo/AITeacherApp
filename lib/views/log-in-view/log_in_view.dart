import 'package:flutter/material.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  @override
  Widget build(BuildContext context) {
    final myScreenWidth = MediaQuery.of(context).size.width;
    //final myScreenHeight = MediaQuery.of(context).size.height;
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
                margin: const EdgeInsets.only(top: 40),
                width: myScreenWidth * 0.9,
                child: Column(
                  children: [
                    TextField(
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
//Password Text Field
                    TextField(
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
//Forgot Password?
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      alignment: Alignment.centerRight,
                      child: Transform.translate(
                        offset: const Offset(10, 0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      ),
                    ),
//Login button
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: myScreenWidth,
                      child: const LogInButton(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
//Or LogIn With Google, Facebook Separation
                    const Row(
                      children: <Widget>[
                        Expanded(child: Divider()),
                        Text(
                          "   Or login with   ",
                          style: TextStyle(fontSize: 15),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        width: myScreenWidth,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFEAEAEA),
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              height: 26,
                              width: 26,
                              image: AssetImage(
                                  "assets/images/icons8-google-96.png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Google',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 8.0),
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 15),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
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
                    text: 'Sign in to your',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      height: 1.1,
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  TextSpan(
                    text: '\nAccount',
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
                    text: '\nSing in to your Account',
                    style: TextStyle(
                      height: 3,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: -1,
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

class LogInButton extends StatelessWidget {
  const LogInButton({super.key});

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
                12.0), // Adjust the value as per your requirement
          ),
        ),
      ),
      onPressed: () {},
      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
