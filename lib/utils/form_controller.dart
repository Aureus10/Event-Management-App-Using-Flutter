import 'package:flutter/material.dart';

final TextEditingController con = TextEditingController()
  ..addListener(() {
    final String text = con.text.toLowerCase();
    con.value = con.value.copyWith(
      text: text,
      selection:
          TextSelection(baseOffset: text.length, extentOffset: text.length),
      composing: TextRange.empty,
    );
  });
