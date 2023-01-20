// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/bloc/image_blocs/image_screen_event.dart';
import 'package:task4/bloc/image_blocs/image_state.dart';
import 'package:task4/repository/get_imageRepo.dart';

class ImageBloc extends Bloc<GetImage,ImageStates>{
ImageRepository imgRepo;

 ImageBloc({required this.imgRepo}) : super(const ImageStates()){

  on<FetchImage>(_retrieveImage);
  on<Closed>(_disposedScreen);
  
 }

 _disposedScreen(event, emit){
  try {
    emit(state.copyWith(
    status: ImageStatus.initial
    ));
    
  } catch (e) {
    emit(state.copyWith(
    status: ImageStatus.failure
    ));
  }
 }

 FutureOr<void> _retrieveImage(event, emit) async{
   askPermission();
   try {
     final data=await imgRepo.pickImage(event.src);
     emit(state.copyWith(
    img: data,
    status: ImageStatus.success
    ));
   } catch (e) {
    emit(state.copyWith(
    status: ImageStatus.failure
    ));
   }
 }

 askPermission() async{
    PermissionStatus status = await Permission.mediaLibrary.request();
    if(status.isDenied == true || status.isPermanentlyDenied)
      {
        askPermission();
      }
    else
      {
        return true;
      }
      return ;
  }
}