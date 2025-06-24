import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../data/variabels.dart';
import '../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  PhoneNumber? number;
  String dialcode = '62', numberphone = '';

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            backgroundColor: Variabels.orange.withAlpha(150),
            content: Text('Tap back again to leave'),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Spacer(),
                            Image.asset(
                              'assets/images/login.webp',
                              width: 200,
                              height: 200,
                            ),
                            const Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Please login to use the features',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 24),
                            IntlPhoneField(
                              controller: phoneController,
                              decoration: const InputDecoration(
                                labelText: 'WhatsApp Number',
                                hintText: '8123456789',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                prefixIcon: Icon(Icons.phone),
                              ),
                              initialCountryCode: 'ID',
                              onChanged: (phone) {
                                dialcode = phone.countryCode.replaceFirst(
                                  RegExp(r'^\+'),
                                  '',
                                );
                                numberphone = phone.number.replaceFirst(
                                  RegExp(r'^0+'),
                                  '',
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    controller.loginUser(
                                      phoneCode: dialcode,
                                      phoneNumber: numberphone,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  backgroundColor: Variabels.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await controller.googleLogin();
                                },
                                icon: Image.asset(
                                  'assets/images/google.webp',
                                  height: 24.0,
                                  width: 24.0,
                                ),
                                label: const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offAllNamed('/register');
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Variabels.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
