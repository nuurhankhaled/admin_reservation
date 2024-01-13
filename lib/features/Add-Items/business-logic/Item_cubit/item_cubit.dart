import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/View-users/data/models/acceptance-model.dart';
import '../../../../Core/Api/endPoints.dart'; // Import the library that defines 'getCategories'.
import 'package:reservationapp_admin/core/helpers/extensions.dart';

import '../../../View-category-details/data/models/items-model.dart';
part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(ItemInitial());

  static ItemCubit get(context) => BlocProvider.of(context);

  static const Duration timeoutDuration = Duration(seconds: 30);

  AddItem(
      {required logo,
      required image1,
      required image2,
      required image3,
      required name,
      required description,
      required price,
      required availableTimeFrom,
      required availableTimeTo,
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
        "available_time_from": availableTimeFrom,
        "available_time_to": availableTimeTo,
        "status": statues,
        "offer": offers,
        "price": price,
        "devices": collectibles,
      });
      print(formData.fields);
      var response =
          await MyDio.post(endPoint: EndPoints.addItem, data: formData);
      print(response!.data);
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.data);
        var jsonResponse = AcceptanceModel.fromJson(decodedData);
        if (jsonResponse.success == true) {
          hideLoading();
          showSuccess("تم اضافه المرفق بنجاح");
          emit(AddItemSuccess());
          ;
        } else {
          showError("حدث خطأ ما");
          print(response!.data);
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

  pickLogo(ImageSource source, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      pickedLogo = imageTemp;

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
      if (response!.statusCode == 200) {
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
      if (response!.statusCode == 200) {
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

  editItem(
      {required id,
      required logo,
      required image1,
      required image2,
      required image3,
      required name,
      required description,
      required price,
      required availableTimeFrom,
      required availableTimeTo,
      required categoryName,
      required statues,
      required address,
      required offers,
      required type,
      required collectibles,
      context}) async {
    emit(EditItemLoading());
    showLoading();
    try {
      print("object");
      FormData formData = FormData.fromMap({
        "category_name": categoryName,
        "name": name,
        "id": id,
        // "logo": await MultipartFile.fromFile(logo.path, filename: fileNameLogo),
        // "image1":
        //     await MultipartFile.fromFile(image1.path, filename: fileNameImage1),
        // "image2":
        //     await MultipartFile.fromFile(image2.path, filename: fileNameImage2),
        // "image3":
        //     await MultipartFile.fromFile(image3.path, filename: fileNameImage3),
        "type": type,
        "description": description,
        "address": address,
        "available_time_from": availableTimeFrom,
        "available_time_to": availableTimeTo,
        "status": statues,
        "offer": offers,
        "price": price,
        "devices": collectibles,
      });

      if (logo != "") {
        String fileNameImage1 = image1.path.split('/').last;
        formData.files.add(MapEntry(
          "logo",
          MultipartFile.fromFileSync(image1.path, filename: fileNameImage1),
        ));
      }

      if (image1 != "") {
        String fileNameImage1 = image1.path.split('/').last;
        formData.files.add(MapEntry(
          "image1",
          MultipartFile.fromFileSync(image1.path, filename: fileNameImage1),
        ));
      }

      if (image2 != "") {
        String fileNameImage2 = image2.path.split('/').last;
        formData.files.add(MapEntry(
          "image2",
          MultipartFile.fromFileSync(image2.path, filename: fileNameImage2),
        ));
      }

      if (image3 != "") {
        String fileNameImage3 = image3.path.split('/').last;
        formData.files.add(MapEntry(
          "image3",
          MultipartFile.fromFileSync(image3.path, filename: fileNameImage3),
        ));
      }
      print(formData.fields);
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
          ;
        } else {
          showError("حدث خطأ ما");
          print(response!.data);
          print(response.statusCode);
          emit(EditItemFailure());
        }
      }
    } catch (e) {
      showError("حدث خطأ ما");
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
