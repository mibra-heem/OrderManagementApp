import 'package:flutter/material.dart';
import 'package:flutter_developer_test/common/utils/app_colors.dart';
import 'package:flutter_developer_test/common/widgets/custom_button.dart';
import 'package:flutter_developer_test/controller/product_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Order extends StatelessWidget {
  Order({super.key});

  Widget space = SizedBox(height: 30.h);

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Page"
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              SizedBox(height: 80.h,),
              orderRows(
                title: "Order #",
                value: controller.orderNoController.text
              ),
              space,
              orderRows(
                title: "Order Name",
                value: "Muhammad Ibrahim"
              ),
              space,
              orderRows(
                title: "Delivery Date",
                value: "November 24th 2024"
              ),
              space,
              orderRows(
                title: "Total Quantity",
                value: controller.totalQty.toString(),
                valueColor: Colors.black,
                valuefontWeight: FontWeight.w400
              ),
              space,
              orderRows(
                title: "Estimated Total",
                value: "\$1402.09",
                valueColor: Colors.black,
                valuefontWeight: FontWeight.w400
              ),
              space,
              SizedBox(
                width: 200.w,
                child: Text(
                    "Deliver To:",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp),
                ),
              ),
              orderRows(
                title: "Location",
                value: "355 onderdonk st Marina Dubai, UAE",
                valueColor: Colors.black,
                valuefontWeight: FontWeight.w400
              ),
              space,
              Text(
                  "Delivery Instructions...",
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
              ),
              space,
              CustomButton(
                width: Get.context!.width * 0.9,
                title: "submit",
                color: AppColors.mainColor,
               onPressed: (){
        
               }
               ),
              space,
              Text(
                  "Save as draft",
                  style: TextStyle(
                      color:AppColors.mainColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget orderRows({
  String? title,
  String? value,
  Color? titleColor,
  Color? valueColor,
  FontWeight? titlefontWeight,
  FontWeight? valuefontWeight,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 2,
        child: Text(
          title ?? "",
          style: TextStyle(
            color: titleColor ?? AppColors.secondColor,
            fontWeight: titlefontWeight ?? FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Text(
          value ?? "",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: valueColor ?? AppColors.mainColor,
            fontWeight: valuefontWeight ?? FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
    ],
  );
}

}