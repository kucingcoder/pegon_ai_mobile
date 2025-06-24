import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import '../controllers/register_controller.dart';

// ignore: must_be_immutable
class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String gender = 'male';
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Image.asset(
                              'assets/images/register.webp',
                              width: 200,
                              height: 200,
                            ),
                            const Text(
                              'Join With Us',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Get alot of benefits and features',
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
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                                hintText: 'Joko Widodo',
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
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: gender,
                              decoration: const InputDecoration(
                                labelText: 'Gender',
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
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'male',
                                  child: Text('Male'),
                                ),
                                DropdownMenuItem(
                                  value: 'female',
                                  child: Text('Female'),
                                ),
                                DropdownMenuItem(
                                  value: 'other',
                                  child: Text('Other'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  gender = value;
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: dobController,
                              decoration: const InputDecoration(
                                labelText: 'Date of Birth',
                                hintText: 'YYYY-MM-DD',
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
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                              onTap: () async {
                                FocusScope.of(
                                  context,
                                ).requestFocus(FocusNode());
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2010, 1, 1),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  dobController.text =
                                      picked.toIso8601String().split('T').first;
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Date of birth is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    controller.registerUser(
                                      name: nameController.text.trim(),
                                      sex: gender,
                                      dateOfBirth: dobController.text.trim(),
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
                                  'Register',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offAllNamed('/login');
                                  },
                                  child: Text(
                                    'Login',
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
