import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String error;
  final double? height;
  final double? width;

  const ErrorDisplay(
    this.error, {
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Material(
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Image.asset(
                'assets/images/warning.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: (height ?? h) * 0.1,
            ),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}

class InfoDisplay extends StatelessWidget {
  final String message;
  final double? height;
  final double? width;

  const InfoDisplay(
    this.message, {
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Material(
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Image.asset(
                'assets/images/information.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: (height ?? h) * 0.1,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
