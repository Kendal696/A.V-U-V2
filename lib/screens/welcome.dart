import 'package:avu/screens/bottom.dart';
import 'package:avu/screens/log_in.dart';
import 'package:avu/screens/sign_up.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  width: 303,
                  child: Text(
                    'Hola, Bienvenido a A.V.U.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0.06,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.6, // Establecer el ancho del contenedor al 60% del ancho de la pantalla
                  child: Image.asset('assets/logo_blanco.png'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.7, // Establecer el ancho del contenedor al 70% del ancho de la pantalla
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LogIn()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9E0044),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical:
                              12), // Aumentar el tamaño vertical del botón
                    ),
                    child: const Text(
                      'Iniciar Sesión',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18, // Aumentar el tamaño de la letra
                        fontWeight: FontWeight.w700,
                        height: 1.4285714286,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.7, // Establecer el ancho del contenedor al 70% del ancho de la pantalla
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomUser()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA7A9AC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical:
                              12), // Aumentar el tamaño vertical del botón
                    ),
                    child: const Text(
                      'Visitante',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18, // Aumentar el tamaño de la letra
                        fontWeight: FontWeight.w700,
                        height: 1.4285714286,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text(
                    'No tienes cuenta?, Registrate aquí',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18, // Aumentar el tamaño de la letra
                      fontWeight: FontWeight.w700,
                      height: 1.4285714286,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
