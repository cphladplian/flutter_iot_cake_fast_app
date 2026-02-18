import 'package:flutter/material.dart';
import 'package:flutter_iot_cake_fast_app/views/cake_shop_list_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => CakeShopListUi())
          );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_welcome.png'),
            fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Text(
                'fastCake',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent
                ),
              ),
              SizedBox(height: 5),
              Text(
                'เค้กด่วน',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              CircularProgressIndicator(
                color: Colors.pinkAccent,
              )
            ],
          )
        )
      ),
    );
  }
}