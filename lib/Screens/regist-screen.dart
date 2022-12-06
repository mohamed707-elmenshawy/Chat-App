
import 'package:chatapp/Screens/login-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Custom Widgets/custom-defult-button.dart';
import '../Custom Widgets/custom-textformfiled.dart';
import '../Custom Widgets/snack-bar.dart';
import '../constans.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  bool isLoading = false;


  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return  ModalProgressHUD(
            inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  Center(
                    child: Text(
                      'Chat App',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Row(
                    children: [
                      Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormTextField(
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButon(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (formKey.currentState!.validate()) {
                                              isLoading = true;
setState(() {
  
});
                        try {
                          await registerUser(email: email,password: password);
                          showSnackBar(context, 'Success');
                                                isLoading = false;
                      setState(() {});
                        Navigator.pushNamed(context, LoginPage.id);
    
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'weak-password') {
                            showSnackBar(context, 'weak password');
                          } else if (ex.code == 'email-already-in-use') {
                            showSnackBar(context, 'email already exists');
                          }
                        }
                        catch (ex) {
                          print(ex.toString());
                          showSnackBar(context, 'there was an error');
                        }
    
                        setState(() {
                          isLoading = false;
    
                        });
                      } else {}
                    },
                    text: 'REGISTER',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'already have an account?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '  Login',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    
      ),
    );
  }

  Future<void> registerUser({required email, required password}) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
//m.elmenshawy888@gmail.com