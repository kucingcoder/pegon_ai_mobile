import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/variabels.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variabels.orange,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          backgroundColor: Variabels.orange.withAlpha(150),
          content: Text('Tap back again to leave'),
        ),
        child: Padding(
          padding: const EdgeInsets.all(64),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset('assets/images/logo.webp', width: 200, height: 200),
                const Text(
                  'PEGON AI',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      shadowColor: Colors.black45,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(360),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: Variabels.orange),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
