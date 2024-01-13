import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservationapp_admin/core/Api/endPoints.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
part 'state.dart';

class AddAdminCubit extends Cubit<AddAdminState> {
  AddAdminCubit() : super(AddAdminInitial());
  static const Duration timeoutDuration = Duration(seconds: 30);

  static AddAdminCubit get(context) => BlocProvider.of(context);

  Future<void> AddAdmin({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String nid,
  }) async {
    emit(AddAdminLoading());

    var response;
    var postData = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phoneNumber,
      "nid": nid,
      // Add other key-value pairs for your form data
    };

    try {
      response = await MyHttp.post(
        endPoint: EndPoints.addAdmin,
        data: postData,
      );
      print('Name: $name');
      if (response != null) {
        print('Response Status Code: ${response.statusCode}');
        if (response.statusCode == 200) {
          emit(AddAdminSuccess());
        } else {
          emit(AddAdminFailure());
        }
      } else {
        // Handle null response
        print('Null response received');
        emit(AddAdminFailure());
      }
    } catch (e) {
      print('Exception occurred: $e');
      emit(AddAdminFailure());
    }
  }
}
