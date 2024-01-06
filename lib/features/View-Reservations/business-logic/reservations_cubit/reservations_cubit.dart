import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationapp_admin/Core/Api/endPoints.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/View-Reservations/data/models/reservations-model.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit() : super(ReservationsInitial());

  static ReservationsCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  List<Data> reservations = [];

  Future<void> getReservations() async {
    emit(GetReservationsLoading());
    try {
      var response = await MyDio.get(endPoint: EndPoints.getReservations);
      print(response!.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        var jsonResponse = ReservationsModel.fromJson(decodedData);
        if (jsonResponse.success!) {
          print("categories");
          reservations = jsonResponse.data!;
          print(reservations);
          emit(GetReservationsSuccess());
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetReservationsFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetReservationsFailure());
      }
    } catch (e) {
      print(e);
      emit(GetReservationsFailure());
    }
  }
}
