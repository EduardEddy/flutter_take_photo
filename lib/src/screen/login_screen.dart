import 'package:flutter/material.dart';
import 'package:fluttertest/src/controllers/auth_controller.dart';
import 'package:fluttertest/src/widgets/body_container_widget.dart';
import 'package:fluttertest/src/widgets/buttom_navigator.dart';
import 'package:fluttertest/src/widgets/input_text.dart';
import 'package:fluttertest/src/widgets/text_title_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String? _email, _password;
  bool indidator = false;
  final AuthController _authController = AuthController();
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
                          title: 'Login',
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
                              return "email invalido";
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
                              return "contraseña invalida";
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
                                Text('LOGIN'),
                                Icon(Icons.login),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.05),
                          child: const ButtomNavigatorWidget(
                            new_route: '/sign_up',
                            title: 'Sign Up',
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
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final SharedPreferences prefs = await _prefs;
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      setState(() {
        indidator = true;
      });
      bool resp = await _authController.authLogin(_email!, _password!, context);
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
