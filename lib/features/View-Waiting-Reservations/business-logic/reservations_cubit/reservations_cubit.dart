import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservationapp_admin/Core/Api/endPoints.dart';
import 'package:reservationapp_admin/core/Api/my_http.dart';
import 'package:reservationapp_admin/core/utilies/easy_loading.dart';
import 'package:reservationapp_admin/features/View-Waiting-Reservations/data/models/reservations-model.dart';
import 'package:reservationapp_admin/features/View-users/data/models/acceptance-model.dart';

part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit() : super(ReservationsInitial());

  static ReservationsCubit get(context) => BlocProvider.of(context);
  static const Duration timeoutDuration = Duration(seconds: 30);

  List<ReservationData> waintingReservations = [];
  List<ReservationData> acceptedReservations = [];

  Future<void> getReservations() async {
    waintingReservations = [];
    acceptedReservations = [];
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
          for (var reservation in jsonResponse.data!) {
            print(reservation.status);
            if (reservation.status == "0") {
              waintingReservations.add(reservation);
            } else {
              acceptedReservations.add(reservation);
            }
          }
          print(waintingReservations.length);
          print("annnnnnnnnaaaaaaaaaa zhhhhhhhh222222222t");
          print(acceptedReservations.length);
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

  Future<void> acceptReservation({required String id, context}) async {
    emit(AcceptReservationLoading());
    showLoading();
    try {
      var response =
          await MyDio.post(endPoint: EndPoints.acceptReservation, data: {
        'id': id,
      });
      print(response!);
      var data = response.data;
      print(data);
      var decodedData = json.decode(response.data);
      var jsonResponse = AcceptanceModel.fromJson(decodedData);
      if (jsonResponse.success == true) {
        showSuccess("تم قبول بنجاح");
        emit(AcceptReservationSuccess());
      } else {
        showError("حدث خطأ ما");
        emit(AcceptReservationFailure());
      }
    } catch (e) {
      print(e.toString());
      emit(AcceptReservationFailure());
    }
  }

  Future<void> declineReservation({required String id, context}) async {
    emit(DeclineReservationLoading());
    showLoading();
    try {
      var response =
          await MyDio.post(endPoint: EndPoints.declineReservation, data: {
        'id': id,
      });
      print(response!);
      var data = response.data;
      print(data);
      var decodedData = json.decode(response.data);
      var jsonResponse = AcceptanceModel.fromJson(decodedData);
      if (jsonResponse.success == true) {
        showSuccess("تم الرفض بنجاح");
        emit(DeclineReservationSuccess());
      } else {
        showError("حدث خطأ ما");
        emit(DeclineReservationFailure());
      }
    } catch (e) {
      print(e.toString());
      emit(DeclineReservationFailure());
    }
  }
}
