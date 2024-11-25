import 'package:flutter/material.dart';

class CustomDialogMessage extends StatelessWidget {
  final String message;
  final Widget child;

  const CustomDialogMessage({
    required this.message,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(message),
              ),
            );
          },
        );
      },
      child: child,
    );
  }
}
