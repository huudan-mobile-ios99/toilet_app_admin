import 'package:flutter/material.dart';
import 'package:toilet_admin/getx/my_getx_controller.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';


Widget rowToiletDisplay({onPress,List<String>? input,isDetail = false }) {

List<dynamic> validateInput(List<String>? input) {
    return input?.map((item) {
      String imageAsset = 'assets/information.png'; // Default image asset
      // Add logic to map each input string to its corresponding image asset
      if (item == MyGetXController.NO_TOILET1) {
        imageAsset = MyGetXController.NO_TOILET1_image;
      } else if (item == MyGetXController.NO_TOILET2) {
        imageAsset = MyGetXController.NO_TOILET2_image;
      }
      else if (item == MyGetXController.NO_TOILET3) {
        imageAsset = MyGetXController.NO_TOILET3_image;
      }
      else if (item == MyGetXController.NO_TOILET4) {
        imageAsset = MyGetXController.NO_TOILET4_image;
      }
      else if (item == MyGetXController.NO_TOILET5) {
        imageAsset = MyGetXController.NO_TOILET5_image;
      }
      else if (item == MyGetXController.NO_TOILET6) {
        imageAsset = MyGetXController.NO_TOILET6_image;
      }
      else if (item == MyGetXController.NO_TOILET7) {
        imageAsset = MyGetXController.NO_TOILET7_image;
      }
      else if (item == MyGetXController.NO_TOILET8) {
        imageAsset = MyGetXController.NO_TOILET8_image;
      }
      return {'text': item, 'imageAsset': imageAsset};
    }).toList() ?? [];
  }

    List<dynamic> validatedList = validateInput(input);
  return  SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:List.generate(
        input!.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:PaddingDefault.pading08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                                        padding: const EdgeInsets.all(PaddingDefault.pading08),
                                        decoration: BoxDecoration(
                                            color:MyColor.greenBG2,
                                            borderRadius: BorderRadius.circular(
                                                PaddingDefault.pading12),
                                            border: Border.all(
                                                color: MyColor.grey_tab4,
                                                width:  1)),
                                        child: Container(
                                          height: isDetail == true ? PaddingDefault.padding64  : PaddingDefault.padding58,
                                          width:isDetail == true ? PaddingDefault.padding64 :  PaddingDefault.padding58,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(validatedList[index]['imageAsset']),
                                                  fit: BoxFit.contain,
                                                  filterQuality: FilterQuality.high)),
                                        ),
                                      ),
              text_custom(text:input[index],weight: FontWeight.w500,size:isDetail==true ? TextSizeDefault.text16 :  TextSizeDefault.text12)
            ],
          ),
        ),
      ),
        ),
  );
}
