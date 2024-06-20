import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/provider/app_provider.dart';
import 'package:zetaton_task/modules/signup/signup_screen.dart';
import 'package:zetaton_task/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Welcome back !',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Center(
                      child: Text(
                        'Login to your account',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    defaultTextFormField(
                      onSubmit: (value) {
                        print(emailController.text);
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                      },
                      prefix: const Icon(Icons.email),
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'example@gmail.com',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    defaultTextFormField(
                      onSubmit: (pass) {
                        print(pass);
                        print(passwordController.text);
                      },
                      validate: (String? pass) {
                        if (pass!.isEmpty || pass.length < 6) {
                          return 'Please enter at least 6 characters';
                        }
                      },
                      prefix: const Icon(Icons.lock),
                      suffix: IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(Icons.visibility_off)),
                      controller: passwordController,
                      hintText: 'your password',
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                      Center(
                        child: Container(
                          width: 160.0,
                          height: 50.0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          child: provider.isLoginIn ?
                         const Center(child: CircularProgressIndicator()):
                          MaterialButton(
                            color: Colors.blueAccent,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                provider.login(email: emailController.text, password: passwordController.text,context: context);
                              }
                            }
                            ,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    const Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 20.0, start: 10.0, end: 10.0,),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'don\'t have an account ?',
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black87),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                              navigateToAndFinish(context,  SignupScreen());
                              },
                              child: const Text(
                                'SignUp Now!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black87),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
