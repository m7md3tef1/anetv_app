import 'package:anetv/featuers/home/data/repo/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets.dart';
import '../models/catogry_itme_model.dart';
import 'addState.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(InitialState());
  static FavCubit get(context) => BlocProvider.of(context);
  List<CatogryItmeModel> favList = [];
  DBHelper db = DBHelper();

  addProduct( ) async {
    // favList.add(contacts);
    print("favList.length");
    // print(favList.length);
    emit(AddFav());
  }

  removeProduct(contacts) {
    favList.remove(contacts);
    print("favList.length");
    print(favList.length);
    emit(DeleteFav());
  }
}
