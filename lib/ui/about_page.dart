import 'package:flutter/material.dart';
import 'package:flutter_pomodoro/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sound effects',
              style: kHeaderTextStyle,
            ),
            InkWell(
              child: Text(
                'zapsplat.com',
                style: kRegularTextStyle,
              ),
              onTap: () => launch('https://www.zapsplat.com'),
            ),
          ],
        ),
      ),
    );
  }
}
