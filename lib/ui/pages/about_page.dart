import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mycashbook_app/shared/theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    'assets/profile_pic.png',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This App Made By',
                    style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
                  ),
                  Text(
                    'Name : Muhammad Shvia',
                    style: blackTextStyle,
                  ),
                  Text(
                    'NIM : 1941720005',
                    style: blackTextStyle,
                  ),
                  Text(
                    'Date Created : 01-10-2023',
                    style: blackTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
