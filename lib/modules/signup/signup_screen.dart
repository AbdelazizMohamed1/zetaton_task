import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/modules/login/login_screen.dart';
import 'package:zetaton_task/provider/app_provider.dart';
import 'package:zetaton_task/shared/components/components.dart';

class SignupScreen extends StatelessWidget {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Exit'),
              content: const Text('Are you sure you want to exit ?'),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Disable'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Enable'),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          },
        );
        return false;
      },
      child: Scaffold(
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
                          'Welcome',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Center(
                        child: Text(
                          'Register Now!',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      defaultTextFormField(
                        controller: firstNameController,
                        textInputType: TextInputType.name,
                        hintText: 'First name',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'First Name is required';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultTextFormField(
                        controller: lastNameController,
                        textInputType: TextInputType.name,
                        hintText: 'Last name',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Last Name is required';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      defaultTextFormField(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'example@gmail.com',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'email must not be empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultTextFormField(
                        controller: phoneController,
                        textInputType: TextInputType.phone,
                        hintText: '+10000000000',
                        validate: (value) {
                          if (!_validateUSPhoneNumber(phoneController.text)) {
                            return 'invalid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      defaultTextFormField(
                        obscureText: true,
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        hintText: 'your password',
                        validate: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password must be 6 character at least';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Confirm Password',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      defaultTextFormField(
                        obscureText: true,
                        controller: rePasswordController,
                        textInputType: TextInputType.visiblePassword,
                        hintText: 'confirm password',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Confirm Password is require';
                          } else if (passwordController.text !=
                              rePasswordController.text) {
                            return 'Password do not match';
                          } else {
                            return null;
                          }
                        },
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
                          child: provider.isRegistered ? const Center(child: CircularProgressIndicator()): MaterialButton(
                            color: Colors.blueAccent,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                provider.register(
                                  fName: firstNameController.text,
                                  lName: lastNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                              }
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: 20.0, start: 10.0, end: 10.0),
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
                          children: [
                            const Text(
                              'Already have an account ?',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black87),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                },
                                child: const Text(
                                  'Login Now!',
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
      ),
    );
  }
  bool _validateUSPhoneNumber(String phoneNumber) {

    final RegExp phoneRegExp = RegExp(r'^\+1\d{10}$');

    // Check if the phone number matches the pattern
    return phoneRegExp.hasMatch(phoneNumber);
  }
}
