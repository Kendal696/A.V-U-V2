import 'package:flutter/material.dart';

enum MethodNavigate { push, replace }

void navigate(
    {required BuildContext context,
    required Widget screen,
    required MethodNavigate method}) {
  switch (method) {
    case MethodNavigate.replace:
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => screen));
      break;
    case MethodNavigate.push:
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      break;
  }
}
