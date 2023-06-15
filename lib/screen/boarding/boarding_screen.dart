import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gips/config/theme/color_pallete.dart';
import 'package:gips/core/global/constans.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SvgPicture.asset(
                'assets/svg/Vector 1.svg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              bottom: kDefaultSpacing,
              right: 0,
              left: 0,
              child: SvgPicture.asset(
                'assets/svg/Vector 2.svg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: kDefaultSpacing * 2,
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/images/gips_logo_small.png',
                height: size.height * 0.4,
              ),
            ),
            Positioned(
              bottom: kDefaultSpacing * 3,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPallete.light.orange,
                      minimumSize: Size(size.width * 0.8, 0),
                      maximumSize: const Size(400, 100),
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultSpacing * 2,
                        vertical: kDefaultSpacing,
                      ),
                    ),
                    child: const Text('Masuk'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: kDefaultSpacing),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width * 0.8, 0),
                        maximumSize: const Size(400, 100),
                        backgroundColor: ColorPallete.light.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultSpacing * 2,
                          vertical: kDefaultSpacing,
                        ),
                      ),
                      child: const Text('Daftar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
