import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import 'hello_controller.dart';

///
/// This is a screen in which we write widgets concerning [HelloScreen]
///

class HelloScreen extends GetView<HelloController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('appName'.tr),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 40.h,
            ),
            child: controller.obx(
              (countries) => ListView.builder(
                shrinkWrap: true,
                itemCount: countries!.length,
                itemBuilder: (_, index) {
                  final country = countries[index];

                  return Text(
                    country.name,
                    style: MyTextStyles.country,
                    textAlign: TextAlign.center,
                  );
                },
              ),
              onEmpty: Text(
                'Empty list of countries',
                style: MyTextStyles.country,
                textAlign: TextAlign.center,
              ),
              onError: (error) => Text(
                error ?? 'No error message',
                style: MyTextStyles.error,
                textAlign: TextAlign.center,
              ),
              onLoading: LoadingAnimationWidget.twistingDots(
                size: 32.r,
                leftDotColor: MyColors.blue,
                rightDotColor: MyColors.green,
              ),
            ),
          ),
        ),
      );
}
