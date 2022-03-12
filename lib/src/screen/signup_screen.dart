import 'package:flutter/material.dart';
import 'package:fluttertest/src/controllers/auth_controller.dart';
import 'package:fluttertest/src/widgets/body_container_widget.dart';
import 'package:fluttertest/src/widgets/buttom_navigator.dart';
import 'package:fluttertest/src/widgets/input_text.dart';
import 'package:fluttertest/src/widgets/text_title_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String? _email, _password;
  bool indidator = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Center(
            child: BodyContainerWidget(
              column: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextTitleWidget(
                          title: 'Sign Up',
                        ),
                        SizedBox(height: size.height * 0.05),
                        InputText(
                          label: 'Email',
                          keyBoardType: TextInputType.emailAddress,
                          onChanged: (String text) {
                            _email = text;
                          },
                          validator: (text) {
                            if (!EmailValidator.validate(text!)) {
                              return "Email invalido";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        InputText(
                          label: 'Password',
                          keyBoardType: TextInputType.emailAddress,
                          obscureText: true,
                          onChanged: (String text) {
                            _password = text;
                          },
                          validator: (text) {
                            if (text!.trim().isEmpty) {
                              return "Contraseña invalida";
                            } else if (text.length < 6) {
                              return "Debe tener al menos 6 caracteres";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.04),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.16),
                          child: ElevatedButton(
                            onPressed: _submit,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text('Crear Cuenta'),
                                Icon(Icons.person_add_alt_rounded),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.05),
                          child: const ButtomNavigatorWidget(
                            new_route: '/',
                            title: 'Login',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: indidator,
            child: Container(
              width: size.width * 1,
              height: size.height * 1,
              color: Colors.white54,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.45,
                    horizontal: size.width * 0.42),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final AuthController _authController = AuthController();
  Future<void> _submit() async {
    final SharedPreferences prefs = await _prefs;
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      setState(() {
        indidator = true;
      });
      bool resp =
          await _authController.authRegister(_email!, _password!, context);
      if (resp) {
        prefs.setString('auth', 'logued');
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (Route<dynamic> route) => false);
      } else {
        setState(() {
          indidator = false;
        });
      }
    }
  }
}
