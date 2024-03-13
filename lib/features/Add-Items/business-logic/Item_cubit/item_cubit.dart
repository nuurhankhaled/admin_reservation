import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/View-users/data/models/acceptance-model.dart';

import '../../../../Core/Api/endPoints.dart';
import '../../../View-category-details/data/models/items-model.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(ItemInitial());

  static ItemCubit get(context) => BlocProvider.of(context);

  static const Duration timeoutDuration = Duration(seconds: 30);

  Future<void> addAvailableTime({
    required availableTimeFrom,
    // required date,
    required availableTimeTo,
    required item_id,
    required price,
  }) async {
    emit(AddItemLoading());

    FormData formData = FormData.fromMap({
      "available_time_from": availableTimeFrom,
      "available_time_to": availableTimeTo,
      // "date": date,
      "item_id": item_id,
      "price": price,
      "status": 0,
    });

    try {
      Response? response = await MyDio.post(
          endPoint: "/item/add_available_time.php", data: formData);

      print(response!.data);
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.data);
        var jsonResponse = AcceptanceModel.fromJson(decodedData);
        if (jsonResponse.success == true) {
          if (!fromadditem) {
            emit(AddItemSuccess());
          }
        } else {
          emit(AddItemFailure());
        }
      }
    } catch (e) {
      print(e);
    }
  }

  bool fromadditem = false;
  AddItem(
      {required logo,
      required image1,
      required image2,
      required image3,
      required name,
      required description,
      required categoryName,
      required statues,
      required address,
      required offers,
      required type,
      required collectibles,
      context}) async {
    emit(AddItemLoading());
    showLoading();
    try {
      String fileNameLogo = logo.path.split('/').last;
      String fileNameImage1 = image1.path.split('/').last;
      String fileNameImage2 = image2.path.split('/').last;
      String fileNameImage3 = image3.path.split('/').last;
      FormData formData = FormData.fromMap({
        "category_name": categoryName,
        "name": name,
        "logo": await MultipartFile.fromFile(logo.path, filename: fileNameLogo),
        "image1":
            await MultipartFile.fromFile(image1.path, filename: fileNameImage1),
        "image2":
            await MultipartFile.fromFile(image2.path, filename: fileNameImage2),
        "image3":
            await MultipartFile.fromFile(image3.path, filename: fileNameImage3),
        "type": type,
        "description": description,
        "address": address,
        // "available_time_from": availableTimeFrom,
        // "available_time_to": availableTimeTo,
        "status": 1,
        "offer": offers,
        //  "price": price,
        "devices": collectibles,
      });
      print(formData.fields);
      var response =
          await MyDio.post(endPoint: EndPoints.addItem, data: formData);
      print(response!.data);
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.data);
        var jsonResponse = AcceptanceModel.fromJson(decodedData);
        print("+++++++++++++++++++++");
        print(jsonResponse);
        if (jsonResponse.success == true) {
          hideLoading();
          showSuccess("تم اضافه المرفق بنجاح");
          emit(AddItemSuccess());
        } else {
          showError("حدث خطأ ما");
          print(response.data);
          print(response.statusCode);
        }
      }
    } catch (e) {
      showError("حدث خطأ ما");

      print("Error while uploading image: $e");
      emit(AddItemFailure());
    }
  }

  File? pickedLogo;

  pickLogo(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      pickedLogo = imageTemp;
      print("Image");
      print(pickedLogo);
      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }

  File? pickedImage1;

  pickImage1(ImageSource source, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      pickedImage1 = imageTemp;
      print("Image");
      print(pickedImage1);
      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }

  File? pickedImage2;

  pickImage2(ImageSource source, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      pickedImage2 = imageTemp;

      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }

  File? pickedImage3;

  pickImage3(ImageSource source, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      pickedImage3 = imageTemp;

      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }

  List<Data> items = [];

  getAllItems() async {
    emit(GetItemsLoading());
    try {
      var response = await MyDio.post(endPoint: EndPoints.getItems, data: {});
      print(response!.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = ItemModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          print("categories");
          items = jsonResponse.data!;
          print(items);
          emit(GetItemsSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetItemsFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetItemsFailure());
      }
    } catch (e) {
      print(e);
      emit(GetItemsFailure());
    }
  }

  deleteItem({required String id}) async {
    emit(DeleteItemLoading());
    showLoading();
    try {
      var response =
          await MyDio.post(endPoint: EndPoints.deleteItem, data: {"id": id});
      print(response!.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = AcceptanceModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          print("categories");
          hideLoading();
          showSuccess("تم حذف المرفق بنجاح");
          emit(DeleteItemSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          showError("حدث خطأ ما");
          emit(DeleteItemFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        showError("حدث خطأ ما");
        emit(DeleteItemFailure());
      }
    } catch (e) {
      print(e);
      showError(e.toString());
      emit(DeleteItemFailure());
    }
  }

  // editItem(
  //     {required id,
  //     required logo,
  //     required image1,
  //     required image2,
  //     required image3,
  //     required name,
  //     required description,
  //     required price,
  //     required availableTimeFrom,
  //     required availableTimeTo,
  //     required categoryName,
  //     required statues,
  //     required address,
  //     required offers,
  //     required type,
  //     required collectibles,
  //     context}) async {
  //   emit(EditItemLoading());
  //   showLoading();
  //   try {
  //     print("object");
  //     String fileNameLogo = (logo != "") ? logo.path.split('/').last : "";
  //     String fileNameImage1 = (image1 != "") ? image1.path.split('/').last : "";
  //     String fileNameImage2 = (image2 != "") ? image2.path.split('/').last : "";
  //     String fileNameImage3 = (image3 != "") ? image3.path.split('/').last : "";
  //     print(fileNameLogo);
  //     FormData formData = FormData.fromMap({
  //       "category_name": categoryName,
  //       "name": name,
  //       "id": id,
  //       "logo": (logo != "")
  //           ? await MultipartFile.fromFile(logo.path, filename: fileNameLogo)
  //           : "",
  //       "image1": (image1 != "")
  //           ? await MultipartFile.fromFile(image1.path,
  //               filename: fileNameImage1)
  //           : "",
  //       "image2": (image2 != "")
  //           ? await MultipartFile.fromFile(image2.path,
  //               filename: fileNameImage2)
  //           : "",
  //       "image3": (image3 != "")
  //           ? await MultipartFile.fromFile(image3.path,
  //               filename: fileNameImage3)
  //           : "",
  //       "type": type,
  //       "description": description,
  //       "address": address,
  //       "available_time_from": availableTimeFrom,
  //       "available_time_to": availableTimeTo,
  //       "status": statues,
  //       "offer": offers,
  //       "price": price,
  //       "devices": collectibles,
  //     });

  //     // if (logo != "") {
  //     //   String fileNameImage1 = image1.path.split('/').last;
  //     //   formData.files.add(MapEntry(
  //     //     "logo",
  //     //     MultipartFile.fromFileSync(image1.path, filename: fileNameImage1),
  //     //   ));
  //     // }

  //     // if (image1 != "") {
  //     //   String fileNameImage1 = image1.path.split('/').last;
  //     //   formData.files.add(MapEntry(
  //     //     "image1",
  //     //     MultipartFile.fromFileSync(image1.path, filename: fileNameImage1),
  //     //   ));
  //     // }

  //     // if (image2 != "") {
  //     //   String fileNameImage2 = image2.path.split('/').last;
  //     //   print(fileNameImage2);
  //     //   formData.files.add(MapEntry(
  //     //     "image2",
  //     //     MultipartFile.fromFileSync(image2.path, filename: fileNameImage2),
  //     //   ));
  //     // }

  //     // if (image3 != "") {
  //     //   String fileNameImage3 = image3.path.split('/').last;
  //     //   formData.files.add(MapEntry(
  //     //     "image3",
  //     //     MultipartFile.fromFileSync(image3.path, filename: fileNameImage3),
  //     //   ));
  //     // }
  //     print("--------------");
  //     print(formData.fields);
  //     print("--------------");
  //     var response =
  //         await MyDio.post(endPoint: EndPoints.editItem, data: formData);
  //     print(response!.data);
  //     if (response.statusCode == 200) {
  //       var decodedData = json.decode(response.data);
  //       var jsonResponse = AcceptanceModel.fromJson(decodedData);
  //       if (jsonResponse.success == true) {
  //         hideLoading();
  //         showSuccess("تم تعديل المرفق بنجاح");
  //         emit(EditItemSuccess());
  //         ;
  //       } else {
  //         showError("حدث خطأ ما");
  //         print(response!.data);
  //         print(response.statusCode);
  //         emit(EditItemFailure());
  //       }
  //     }
  //   } catch (e) {
  //     showError("حدث خطأ ما");
  //     emit(EditItemFailure());
  //   }
  // }

  editItem({
    required id,
    required logo,
    required image1,
    required image2,
    required image3,
    required name,
    required description,
    required categoryName,
    required statues,
    required address,
    required offers,
    required type,
    required collectibles,
    context,
  }) async {
    emit(EditItemLoading());
    showLoading();

    String fileNameLogo = "";
    if (logo != null) {
      fileNameLogo = logo.path.split('/').last;
    }

    print(fileNameLogo);

    String fileNameImage1 = "";
    if (image1 != null) {
      fileNameImage1 = image1.path.split('/').last;
    }
    String fileNameImage2 = "";
    if (image2 != null) {
      fileNameImage2 = image2.path.split('/').last;
    }
    String fileNameImage3 = "";
    if (image3 != null) {
      fileNameImage3 = image3.path.split('/').last;
    }

    FormData formData = FormData();

    formData.fields.addAll([
      MapEntry("category_name", categoryName),
      MapEntry("name", name),
      MapEntry("id", id),
      MapEntry("type", type),
      MapEntry("description", description),
      MapEntry("address", address),
      // MapEntry("available_time_from", availableTimeFrom),
      // MapEntry("available_time_to", availableTimeTo),
      MapEntry("status", statues),
      MapEntry("offer", offers),
      //  MapEntry("price", price),
      MapEntry("devices", collectibles),
    ]);

    if (fileNameLogo != "" || logo != null) {
      formData.files.add(MapEntry(
        "logo",
        await MultipartFile.fromFile(logo.path, filename: fileNameLogo),
      ));
    }

    if (fileNameImage1 != "" || image1 != null) {
      formData.files.add(MapEntry(
        "image1",
        await MultipartFile.fromFile(image1.path, filename: fileNameImage1),
      ));
      print("hna");
    }

    if (fileNameImage2 != "" || image2 != null) {
      formData.files.add(MapEntry(
        "image2",
        await MultipartFile.fromFile(image2.path, filename: fileNameImage2),
      ));
    }

    if (fileNameImage3 != "" || image3 != null) {
      formData.files.add(MapEntry(
        "image3",
        await MultipartFile.fromFile(image3.path, filename: fileNameImage3),
      ));
    }

    print("chekcing");
    print(logo != "" && logo != null);
    print(image1 != "" && image1 != null);

    print(image2 != "" && image2 != null);

    print(image3 != "" && image3 != null);

    print("Uploading");

    // String fileNameLogo = "";
    // print(fileNameLogo);
    // if (logo != null) {
    //   fileNameLogo = logo.path;
    // }

    // String fileNameImage1 = "";
    // if (image1 != null) {
    //   fileNameImage1 = image1.path;
    // }

    // String fileNameImage2 = "";
    // if (image2 != null) {
    //   fileNameImage2 = image2.path;
    // }
    // String fileNameImage3 = "";
    // if (image3 != null) {
    //   fileNameImage3 = image3.path;
    // }

    // Map<String, dynamic> data = {
    //   "category_name": categoryName,
    //   "name": name,
    //   "logo": fileNameLogo,
    //   "image1": fileNameImage1,
    //   "image2": fileNameImage2,
    //   "image3": fileNameImage3,
    //   "id": id,
    //   "type": type,
    //   "description": description,
    //   "address": address,
    //   "available_time_from": availableTimeFrom,
    //   "available_time_to": availableTimeTo,
    //   "status": statues,
    //   "offer": offers,
    //   "price": price,
    //   "devices": collectibles,
    // };

    print("--------------");
    // data.forEach((key, value) {
    //   print('$key: $value');
    // });

    for (var field in formData.fields) {
      print('${field.key}: ${field.value}');
    }
    print("--------------");
    try {
      var response =
          await MyDio.post(endPoint: EndPoints.editItem, data: formData);
      print(response!.data);

      if (response.statusCode == 200) {
        var decodedData = json.decode(response.data);
        var jsonResponse = AcceptanceModel.fromJson(decodedData);

        if (jsonResponse.success == true) {
          hideLoading();
          showSuccess("تم تعديل المرفق بنجاح");
          emit(EditItemSuccess());
        } else {
          showError("حدث خطأ ما");
          print(response.data);
          print(response.statusCode);
          hideLoading();
          emit(EditItemFailure());
        }
      }
    } catch (e) {
      showError("حدث خطأ ما");
      print("حدث خطأ ما");
      print(e.toString());
      hideLoading();
      emit(EditItemFailure());
    }
  }

  File? editedLogo;

  editLogo(ImageSource source, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      editedLogo = imageTemp;

      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }

  File? editedImage1;

  editImage1(ImageSource source, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      editedImage1 = imageTemp;

      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }

  File? editedImage2;

  editImage2(ImageSource source, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      editedImage2 = imageTemp;

      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }

  File? editedImage3;

  editImage3(ImageSource source, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      editedImage3 = imageTemp;

      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }
}
