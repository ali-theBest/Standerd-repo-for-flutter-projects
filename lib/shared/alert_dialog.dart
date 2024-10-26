import 'package:flutter/material.dart';

import '../core/utils/images.dart';
import '../core/utils/strings.dart';
import '../core/utils/styles.dart';

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          height: 260,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeOut,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetImages.applogo),
                const SizedBox(height: 20),
                FittedBox(
                  child: Text(
                    Strings.alerText,
                    style: FontStyles.font16WeightBoldText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  Future.delayed(Duration(seconds: 2), () {
    print("Dialog closed"); // لطباعة رسالة عند الإغلاق
  });
}
