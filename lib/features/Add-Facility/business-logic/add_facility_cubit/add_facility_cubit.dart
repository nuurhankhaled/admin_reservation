import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import '../../../../Core/Api/endPoints.dart';
part 'add_facility_state.dart';

class AddFacilityCubit extends Cubit<AddFacilityState> {
  AddFacilityCubit() : super(AddFacilityInitial());

  static AddFacilityCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  saveImage({required image, required name, context}) async {
    emit(AddFacilityLoading());
    showLoading();
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
        "name": name
      });
      var response =
          await MyHttp.post(endPoint: EndPoints.addFacility, data: formData);
      print(response!.body);
      if (response.statusCode == 200) {
        hideLoading();
        showSuccess("تم اضافه المرفق بنجاح");
        emit(AddFacilitySuccess());
      } else {
        showError("حدث خطأ ما");
        print(response!.body);
        print(response.statusCode);
      }
    } catch (e) {
      showError("حدث خطأ ما");

      print("Error while uploading image: $e");
      emit(AddFacilityFailure());
    }
  }

  File? pickedImage;

  pickImage(ImageSource source, name, context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      pickedImage = imageTemp;

      saveImage(image: image, name: name, context: context);
      emit(PickImageSuccessState());
    } catch (e) {
      print("failed to pick image : $e");
      emit(PickImageErrorState(e.toString()));
    }
  }
}
