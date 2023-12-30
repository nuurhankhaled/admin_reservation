import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mainlayout_state.dart';

class MainlayoutCubit extends Cubit<MainlayoutState> {
  MainlayoutCubit() : super(MainlayoutInitial());

  static MainlayoutCubit get(context) => BlocProvider.of(context);


  String selectedItem = "/dashboard";

  void changeSelectedItem(currentItem) {
    selectedItem = currentItem;
    emit(CurrentItemChangedState());
  }
}
