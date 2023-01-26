// ignore_for_file: depend_on_referenced_packages, use_rethrow_when_possible

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:task4/bloc/image_blocs/image_screen_event.dart';
import 'package:task4/bloc/image_blocs/image_state.dart';
import 'package:task4/repository/get_imageRepo.dart';

class ImageBloc extends Bloc<GetImage,ImageStates>{
ImageRepository imgRepo;
File? data;
 ImageBloc({required this.imgRepo}) : super( const ImageStates()){

  on<FetchImage>(_retrieveImage);
  
 }

 FutureOr<void> _retrieveImage(event, emit) async{
   try {
    data=await imgRepo.pickImage(event.src);
     emit(
    state.copyWith(
    img: data,
    status: ImageStatus.success
    ));
   } catch (e) {
    emit(state.copyWith(
    status: ImageStatus.failure,
    img:data
    ));
   }
 }

}