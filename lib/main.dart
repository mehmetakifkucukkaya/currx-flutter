import 'package:currx/controllers/currency_controller.dart';
import 'package:currx/controllers/gold_controllers.dart';
import 'package:currx/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  
  await dotenv.load(fileName: ".env");

  runApp(
    GetMaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(CurrencyController());
        Get.put(GoldController());
      }),
    ),
  );
}
