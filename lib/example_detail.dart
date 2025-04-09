import 'package:flutter/material.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';

class ExampleDetailPage extends StatefulWidget {
  const ExampleDetailPage({super.key});
  @override
  State<ExampleDetailPage> createState() => _ExampleDetailPageState();
}

class _ExampleDetailPageState extends State<ExampleDetailPage> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: height,
            width: width,
            padding:  const EdgeInsets.symmetric(
                horizontal: PaddingDefault.padding24,
                vertical: PaddingDefault.padding24),
            child: ElevatedButton(onPressed: (){
              
            },child: text_custom(text:"OK"),)));
  }
}
