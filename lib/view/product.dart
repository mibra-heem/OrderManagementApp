import 'dart:io';
import 'package:flutter/material.dart';
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
          title: const Text('Add Product'),
          centerTitle: true,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          leading: const Icon(Icons.menu),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            tooltip: 'Add rows',
            child: const Center(child: Icon(Icons.add)),
            onPressed: () {
              controller.addRow();
            }),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<ProductController>(builder: (controller) {
                  return controller.isActionEnabled
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.clearFields();
                                },
                                icon: const Icon(Icons.close)),
                            IconButton(
                                onPressed: () {
                                  controller.addQuantity();
                                  Get.to(Order());
                                },
                                icon: const Icon(Icons.arrow_forward))
                          ],
                        )
                      : const SizedBox();
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
                        height: 19.h,
                        child: TextField(
                          cursorColor: AppColors.mainColor,
                          controller: controller.orderNoController,
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                          decoration: const InputDecoration(
                              hintText: '112096',
                              hintStyle: TextStyle(color: AppColors.mainColor),
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              isCollapsed: true,
                              isDense: true),
                        ))
                  ],
                ),
                SizedBox(height: 20.h),
                GetBuilder<ProductController>(
                  builder: (ProductController controller) {
                    return Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(
                          color: AppColors.mainColor,
                          width: 0.5.w,
                        ),
                      ),
                      columnWidths: {
                        0: FixedColumnWidth(70.w),
                      },
                      children: List.generate(controller.rows, (index) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12.w, right: 6.w, top: 6.h),
                              child: TextField(
                                controller: controller.qtyControllers[index],
                                focusNode: controller.qtyFocusNodes[index],
                                onChanged: (value) {
                                  controller.moveQtyFocus(index, context);
                                  controller.toggleActionButtons();
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
                                                      (TextEditingValue textEditingValue) {
                                                    if (textEditingValue.text.isEmpty) {
                                                      return const Iterable<String>.empty();
                                                    }
                                                    return controller.products.where((product) {
                                                      return product
                                                          .toLowerCase()
                                                          .contains(textEditingValue.text.toLowerCase());
                                                    });
                                                  },
                                                  onSelected:(String selection) {},
                                                  fieldViewBuilder: (context,
                                                      textEditingController,
                                                      focusNode,
                                                      onFieldSubmitted) {
                                                    controller.focusNodes.add(focusNode);
                                                    controller.productControllers.add(textEditingController);
                                                    return TextField(
                                                      onChanged: (value) {
                                                        controller.moveFocus(index, context);
                                                        controller.toggleActionButtons();
                                                      },
                                                      controller:
                                                          textEditingController,
                                                      focusNode: focusNode,
                                                      onSubmitted: (_) =>
                                                          onFieldSubmitted
                                                              .call(),
                                                      decoration:
                                                          const InputDecoration(border: InputBorder.none,),
                                                    );
                                                  },
                                                ),
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onLongPress: () {
                                              controller.isDialogButton = false;
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
                                                      child: InteractiveViewer(
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
