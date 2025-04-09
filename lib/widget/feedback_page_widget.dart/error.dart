import 'package:flutter/material.dart';
import 'package:toilet_admin/utils/text.dart';

Widget error_line(onPressed){
  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        text_custom(text: 'An error orcur'),
                        TextButton(
                            onPressed: onPressed,
                            child: text_custom(text: "Refresh"))
                      ],
                    );
}