import 'dart:async';

import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/app/domain/entities/category_entity.dart';
import 'package:ecommerce_app/feature/app/domain/usecase/category/get_all_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllCategories _getAppCategories;
  List<CategoryEntity> _allCategories = [];

  HomeBloc(this._getAppCategories) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      emit(HomeLoading());
    });
    on<HomeLoadCategories>(_onLoadCategories);
    on<HomeSearchCategories>(_onSearchCategories);
  }

  FutureOr<void> _onLoadCategories(
      HomeLoadCategories event, Emitter<HomeState> emit) async {
    final result = await _getAppCategories(NoParams());
    result.fold(
          (failure) => emit(HomeError(failure.message)),
          (categories) {
        _allCategories = categories;
        emit(HomeLoaded(categories));
      },
    );
  }

  FutureOr<void> _onSearchCategories(
      HomeSearchCategories event, Emitter<HomeState> emit) async {
    final filteredCategories = _allCategories
        .where((category) =>
        category.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    if (filteredCategories.isEmpty) {
      emit(HomeNoResults());
    } else {
      emit(HomeLoaded(filteredCategories));
    }
  }
}