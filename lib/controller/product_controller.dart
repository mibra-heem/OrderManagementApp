import 'package:flutter/material.dart';
import '../common/api/api_client.dart';
import '../common/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  ApiClient apiClient;
  ProductController({required this.apiClient});

  int rows = 12;
  int totalQty = 0;
  final _imagePicker = ImagePicker();
  final orderNoController = TextEditingController();

  bool isDialogButton = false;
  bool isNote = false;
  bool isImage = false;
  bool isLoading = true;
  bool isActionEnabled = false;

  List<String> products = [];
  List<bool> isNoteForFields = [];
  List<bool> isImageForFields = [];
  List<TextEditingController> noteControllers = [];
  List<TextEditingController> productControllers = [];
  List<TextEditingController> qtyControllers = [];
  List<FocusNode> focusNodes = [];
  List<FocusNode> qtyFocusNodes = [];
  List<XFile?>? images;

  @override
  void onInit() async {
    super.onInit();
    print("Controller initialized");

    isNoteForFields = List<bool>.generate(rows, (index) => false);
    isImageForFields = List<bool>.generate(rows, (index) => false);
    noteControllers = List<TextEditingController>.generate(
        rows, (index) => TextEditingController());
    qtyControllers = List<TextEditingController>.generate(
        rows, (index) => TextEditingController());
    qtyFocusNodes = List<FocusNode>.generate(rows, (index) => FocusNode());
    images = List<XFile?>.generate(rows, (index) => null);
    await getProducts();
    update();
  }

  void toggleActionButtons() {
    for (int i = 0; i < productControllers.length; i++) {
      if (productControllers[i].text.isNotEmpty &&
          qtyControllers[i].text.isNotEmpty) {
        isActionEnabled = true;
        update();
        break;
      }

      if (productControllers[i].text.isEmpty &&
          qtyControllers[i].text.isEmpty) {
        isActionEnabled = false;
        update();
        break;
      }
    }
  }

  void addQuantity() {
    totalQty = 0;
    for (int i = 0; i < qtyControllers.length; i++) {
      totalQty += int.tryParse(qtyControllers[i].text) ?? 0;
    }
  }

  Future<void> pickImageFromGallery(int index) async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      images![index] = image;
      isImage = true;
      update();
    }
  }

  void moveFocus(int index, BuildContext context) {
    if (index < productControllers.length) {
      for (int i = 0; i < productControllers.length; i++) {
        if (productControllers[i].text.isEmpty && i < index) {
          productControllers[index].text = "";
          FocusScope.of(context).requestFocus(focusNodes[i]);
          break;
        }
      }
    }
  }

  void moveQtyFocus(int index, BuildContext context) {
    if (index < qtyControllers.length) {
      for (int i = 0; i < qtyControllers.length; i++) {
        if (qtyControllers[i].text.isEmpty && i < index) {
          qtyControllers[index].text = "";
          FocusScope.of(context).requestFocus(qtyFocusNodes[i]);
          break;
        }
      }
    }
  }

  void setNoteForField(int index, bool flag) {
    for (int i = 0; i < isNoteForFields.length; i++) {
      if (i == index) {
        isNoteForFields[i] = flag;
      }
    }
    update();
  }

  bool isNoteForField(int index) {
    return isNoteForFields[index];
  }

  void setImageForField(int index, bool flag) {
    for (int i = 0; i < isImageForFields.length; i++) {
      if (i == index) {
        isImageForFields[i] = flag;
      }
    }
    update();
  }

  bool isImageForField(int index) {
    return isImageForFields[index];
  }

  void toggleBox() {
    isDialogButton = !isDialogButton;
    update();
  }

  void addRow() {
    var productLength = productControllers.length;
    var qtyLength = qtyControllers.length;
    if (productControllers[productLength - 1].text.isNotEmpty &&
        qtyControllers[qtyLength - 1].text.isNotEmpty) {
      rows++;
      isNoteForFields.add(false);
      isImageForFields.add(false);
      noteControllers.add(TextEditingController());
      qtyControllers.add(TextEditingController());
      qtyFocusNodes.add(FocusNode());
      images?.add(null); // Add a null value for the new row
      update();
    }
  }

  Future<void> getProducts() async {
    Response response = await apiClient.getData(AppConstant.API_SAMPLE);

    if (response.statusCode == 200) {
      var data = response.body;

      products =
          List<String>.from(data.values.map((value) => value.toString()));
      print("Products: $products");
    } else {
      print("Error: ${response.statusCode}");
    }

    isLoading = false;
    update();
  }

  void clearFields() {
    for (int i = 0; i < productControllers.length; i++) {
      productControllers[i].clear();
      noteControllers[i].clear();
      qtyControllers[i].clear();
      if (images != null && i < images!.length) {
        images![i] = null;
      }
      setImageForField(i, false);
      setNoteForField(i, false);
      isActionEnabled = false;
    }
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    for (var controller in productControllers) {
      controller.dispose();
    }

    for (var controller in noteControllers) {
      controller.dispose();
    }
  }
}
