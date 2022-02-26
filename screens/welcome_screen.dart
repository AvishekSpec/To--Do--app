import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/data_provider.dart';
import 'package:to_do/screens/task_screen.dart';

import '../sign_button.dart';

class WelcomeScreen extends StatelessWidget {
  static String route_name = '/';
  late String username;
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String userName;

    return Scaffold(
      body: Container(
        color: Colors.blue[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Text(
                'ENTER YOUR USERNAME',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
              margin: EdgeInsets.fromLTRB(30.0, 40.0, 40.0, 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2.0, color: Color(0xCBC7C7B3)),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: TextFormField(
                onChanged: (value) {
                  username = value;
                },
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.blue[900],
                  ),
                  border: InputBorder.none,
                  hintText: 'username',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            SignButton(
              bgColor: Colors.black,
              textButton: 'Let\'s Start',
              onPress: () {
                Provider.of<Data>(context, listen: false).setName(username);
                Navigator.pushNamed(context, TaskScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
