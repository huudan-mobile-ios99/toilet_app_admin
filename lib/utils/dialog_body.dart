import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toilet_admin/getx/my_getx_controller.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';
import 'package:toilet_admin/widget/button_custom.dart';

Widget dialogBody({height, width, MyGetXController? controller_getx}) {
  return Container(
    width: width * .825,
    height: height * .725,
    decoration: BoxDecoration(
        color: MyColor.white, borderRadius: BorderRadius.circular(45)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //gridview builder
        Container(
          height: height * .555,
          width: width * .825,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PaddingDefault.padding24),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(PaddingDefault.padding24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 2 columns
                crossAxisSpacing: PaddingDefault.padding24,
                mainAxisSpacing: PaddingDefault.padding24,
                childAspectRatio: 1),
            itemCount: controller_getx!.items.length,
            itemBuilder: (context, index) {
              var item = controller_getx.items[index];
              return GestureDetector(
                  onTap: () {
                    print('ontap $index ${controller_getx.items[index].name} ${controller_getx.items[index].isSelect} ');
                    // controller_getx.toggleSelection(index);
                  },
                  child: Column(
                    children: [
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.all(PaddingDefault.padding24),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  PaddingDefault.padding24),
                              border: Border.all(
                                  color:
                                      controller_getx.items[index].isSelect ==
                                              true
                                          ? MyColor.purpleBG
                                          : MyColor.black_text,
                                  width:
                                      controller_getx.items[index].isSelect ==
                                              true
                                          ? 5
                                          : 1)),
                          child: Container(
                            height: 85.0,
                            width: 85.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        controller_getx.items[index].image),
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: PaddingDefault.pading08,
                      ),
                      text_custom(
                          text: controller_getx.items[index].name,
                          size: TextSizeDefault.text16,
                          weight: FontWeight.w500)
                    ],
                  ));
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        GetBuilder<MyGetXController>(
          builder: (controller) {
            return customPressButton(
              padding: PaddingDefault.padding24,
              width: 175.0,
              onPress: () {
                // controller_getx.turnOff();
                // controller.resetForm();
                print('content: ${controller.selectedItemNames.value.toString()}');
                print('star: ${controller.starCount.value}');
              },
              child: Container(
                width: 175.0,
                height: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: MyColor.yellowBG2,
                    border: Border.all(color: MyColor.white),
                    borderRadius: BorderRadius.circular(25)),
                child: text_custom(
                    text: 'SUBMIT',
                    size: TextSizeDefault.text28,
                    weight: FontWeight.bold,
                    color: MyColor.white),
              ),
            );
          },
        ),
        const SizedBox(
          height: PaddingDefault.pading12,
        ),
        Obx(() => text_custom(
            text:
                'Auto submit after ${controller_getx.count.value} seconds without action',
            size: TextSizeDefault.text16,
            color: MyColor.grey,
            weight: FontWeight.w300))
      ],
    ),
  );
}
