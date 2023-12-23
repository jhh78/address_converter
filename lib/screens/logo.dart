import 'package:flutter/material.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.white10,
      ),
      child: const FadeInImage(
        placeholder: AssetImage('assets/images/empty.png'),
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.contain,
      ),
    );
  }
}
