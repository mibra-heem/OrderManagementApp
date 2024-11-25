import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_developer_test/view/order.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_developer_test/controller/product_controller.dart';
import '../common/utils/app_colors.dart';
import '../common/widgets/custom_dialog_message.dart';
import '../common/widgets/custom_dialog_options.dart';

class Product extends GetView<ProductController> {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 120.h,
          flexibleSpace: Center(
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: const Icon(
            Icons.menu,
            color: AppColors.mainColor,
          ),
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<ProductController>(builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (controller.isActionEnabled) {
                              controller.clearFields();
                            }
                          },
                          icon: Icon(
                            Icons.close,
                            color: controller.isActionEnabled
                                ? AppColors.mainColor
                                : Colors.grey,
                          )),
                      IconButton(
                          onPressed: () {
                            if (controller.isActionEnabled) {
                              if (controller.orderNoController.text.isEmpty) {
                                controller.orderNoController.text = "112096";
                              }
                              controller.addQuantity();
                              Get.to(Order());
                            }
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: controller.isActionEnabled
                                ? AppColors.mainColor
                                : Colors.grey,
                          ))
                    ],
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 70.w,
                      height: 19.h,
                      child: Text(
                        "Order #",
                        style: TextStyle(
                            color: AppColors.secondColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                        width: 120.w,
                        height: 20.h,
                        child: TextField(
                          cursorColor: AppColors.mainColor,
                          controller: controller.orderNoController,
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                          decoration: const InputDecoration(
                              hintText: '112096',
                              hintStyle:
                                  TextStyle(color: AppColors.mainColor),
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              isCollapsed: true,
                              isDense: true),
                        ))
                  ],
                ),
                SizedBox(height: 30.h),
                GetBuilder<ProductController>(
                  builder: (ProductController controller) {
                    return Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(
                          color: AppColors.mainColor,
                          width: 1.w,
                        ),
                      ),
                      columnWidths: {
                        0: FixedColumnWidth(70.w),
                      },
                      children: List.generate(controller.rows, (index) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 12.w, right: 6.w, top: 6.h),
                              child: TextField(
                                controller: controller.qtyControllers[index],
                                focusNode: controller.qtyFocusNodes[index],
                                keyboardType: TextInputType
                                    .number, // Allows only numeric keyboard
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Restricts input to digits only
                                ],
                                onChanged: (value) {
                                  controller.moveQtyFocus(index, context);
                                  controller.toggleActionButtons();
                                  controller.addRow();
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.w, top: 6.h),
                              child: SizedBox(
                                height: 40.h,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: Stack(
                                        children: [
                                          controller.isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : Autocomplete<String>(
                                                  optionsBuilder:
                                                      (TextEditingValue
                                                          textEditingValue) {
                                                    if (textEditingValue
                                                        .text.isEmpty) {
                                                      return const Iterable<
                                                          String>.empty();
                                                    }
                                                    return controller.products
                                                        .where((product) {
                                                      return product
                                                          .toLowerCase()
                                                          .contains(
                                                              textEditingValue
                                                                  .text
                                                                  .toLowerCase());
                                                    });
                                                  },
                                                  onSelected:
                                                      (String selection) {},
                                                  fieldViewBuilder: (context,
                                                      textEditingController,
                                                      focusNode,
                                                      onFieldSubmitted) {
                                                    controller.focusNodes
                                                        .add(focusNode);
                                                    controller
                                                        .productControllers
                                                        .add(
                                                            textEditingController);
                                                    return TextField(
                                                      onChanged: (value) {
                                                        controller.moveFocus(
                                                            index, context);
                                                        controller
                                                            .toggleActionButtons();
                                                        controller.addRow();
                                                      },
                                                      controller:
                                                          textEditingController,
                                                      focusNode: focusNode,
                                                      onSubmitted: (_) =>
                                                          onFieldSubmitted
                                                              .call(),
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    );
                                                  },
                                                ),
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onLongPress: () {
                                              controller.isDialogButton =
                                                  false;
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomDialogOptions(
                                                      fieldId: index);
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    controller.isNoteForField(index)
                                        ? CustomDialogMessage(
                                            message: controller
                                                .noteControllers[index].text,
                                            child: const Icon(
                                              Icons.info_outline,
                                              color: AppColors.mainColor,
                                            ),
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    controller.isImageForField(index)
                                        ? GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child:
                                                          InteractiveViewer(
                                                        panEnabled:
                                                            true, // Enable panning
                                                        minScale:
                                                            0.5, // Minimum zoom level
                                                        maxScale:
                                                            4.0, // Maximum zoom level
                                                        child: controller
                                                                        .images![
                                                                    index] !=
                                                                null
                                                            ? Image.file(
                                                                File(controller
                                                                    .images![
                                                                        index]!
                                                                    .path),
                                                                fit: BoxFit
                                                                    .contain,
                                                              )
                                                            : const SizedBox(),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: const Icon(
                                              Icons.camera_alt,
                                              color: AppColors.mainColor,
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
