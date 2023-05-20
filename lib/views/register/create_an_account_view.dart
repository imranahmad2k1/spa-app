import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CreateAnAccountView extends StatelessWidget {
  const CreateAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 118),
            const Text(
              'Create an Account',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Please complete your profile. \nDon’t worry, your data will remain private\nand only you can see it',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Color(dividerColor),
              height: 11,
              indent: 45,
              endIndent: 45,
            ),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 170,
                  height: 37,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 170,
                  height: 37,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last name',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const SizedBox(
              height: 37,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email address',
                ),
              ),
            ),
            const SizedBox(height: 22),
            const SizedBox(
              height: 37,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New pasword',
                ),
              ),
            ),
            const SizedBox(height: 208),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(30),
              child: Ink(
                width: 268,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(primaryColor),
                ),
                child: const Center(
                    child: Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
