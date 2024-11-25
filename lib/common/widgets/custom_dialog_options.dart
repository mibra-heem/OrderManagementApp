import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_developer_test/controller/product_controller.dart';

import '../utils/app_colors.dart';
import 'custom_button.dart';

// ignore: must_be_immutable
class CustomDialogOptions extends StatelessWidget {

  int fieldId;

  CustomDialogOptions({super.key, required this.fieldId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: controller.isDialogButton ? 180 : 100,
            child: controller.isDialogButton
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: controller.noteControllers[fieldId],
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Add Note...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                          width: 80,
                          title: "Save",
                          color: AppColors.mainColor,
                          onPressed: (){
                            Navigator.pop(context);
                            // controller.showNote();
                            controller.setNoteForField(fieldId, true);
                          }
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DialogButton(
                        text: "Add Note",
                        icon: Icons.note_add,
                        onTap: () {
                          controller.toggleBox();
                        },
                      ),
                      DialogButton(
                          text: "Add Image",
                          icon: Icons.image,
                          onTap: () async {
                            Navigator.pop(context);
                            await controller.pickImageFromGallery(fieldId);
                            if(controller.images![fieldId] != null){
                              controller.setImageForField(fieldId, true);
                            }
                            
                          }),
                    ],
                  ),
          ),
        ),
      );
    });
  }

  Widget DialogButton({
    String text = '',
    Color? textColor,
    Color? iconColor,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: onTap ?? () {},
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                icon ?? Icons.add,
                color: iconColor ?? Colors.black,
              ),
            )),
        Text(
          text,
          style: TextStyle(color: textColor ?? Colors.black),
        )
      ],
    );
  }
}
