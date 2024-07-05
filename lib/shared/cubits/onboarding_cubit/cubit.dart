import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubits/onboarding_cubit/states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates>
{
  OnBoardingCubit() : super(InitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  bool isLastPage = false;

  void listenPageLastIndex(bool isLast)
  {
    isLastPage = isLast;
    emit(ChangePageLastIndexState());
  }
}