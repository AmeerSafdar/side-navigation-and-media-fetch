// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/bloc/audio_blocs/audio_events.dart';
import 'package:task4/bloc/audio_blocs/audio_state.dart';
import 'package:task4/bloc/audio_blocs/audio_bloc.dart';
import 'package:task4/helper/const/const.dart';
import 'package:task4/helper/const/icon_helper.dart';
import 'package:task4/helper/const/string_helper.dart';
import 'package:task4/representation/widget/button_widget.dart';
import 'package:task4/representation/widget/text_widget.dart';

import '../../widget/drawerWidget.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  Duration? positions, durations;
  late Timer? timer;
  getDuration(){
    timer=Timer.periodic(Duration(seconds: 1), (Timer t) => BlocProvider.of<AudioBlocs>(context).add(GetDuration()));
  }
  @override
  void initState() {
    super.initState();
   
  }  
  @override
void didChangeDependencies() {
    super.didChangeDependencies();
    getDuration();
}

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  String _printDuration(Duration? duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  if (duration != null) {
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
  return '';
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: BlocBuilder<AudioBlocs, AudioStates>(
        builder: (context, state) {
          return FloatingActionButton(
              onPressed: () {
               if (state.audio != null) 
               { 
                if (state.status==AudioStatus.pause|| state.status==AudioStatus.drag) {
                  BlocProvider.of<AudioBlocs>(context).add(Play());
                } else if(state.status==AudioStatus.success  ){
                  BlocProvider.of<AudioBlocs>(context).add(Pause());
                }
                if (state.status==AudioStatus.failure && state.audio !=null) {
                  BlocProvider.of<AudioBlocs>(context).add(Play());
                  
                }
                }

                } , 
                child:(state.status== AudioStatus.pause ||( state.status== AudioStatus.failure && state.audio!=null)) ? IconHelper.PLAY_ICON : IconHelper.PAUSE_ICON);
        },
      ),
      drawer: DrawerWidget(),
      appBar: AppBar(title: TextWidget(txt:StringHelp.AUDIO_SCREEN),),
      
      body: Center(
        child: BlocBuilder<AudioBlocs, AudioStates>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(state.status == AudioStatus.success && state.duration !=null )
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            txt: _printDuration(state.position),
                            ),
                        ),
                        Flexible(
                          child: Slider(
                            min:0 ,
                            max:state.duration !=null ? state.duration!.inMilliseconds.toDouble():0.0 ,
                            value:state.position !=null ? state.position!.inMilliseconds.toDouble():0.0 , 
                            onChanged: (val){
                              durations=Duration(microseconds: (val * 1000).toInt());
                              BlocProvider.of<AudioBlocs>(context).add(Drag(durations));
                             
                          }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            txt: _printDuration(state.duration),
                            ),
                          
                        ),
                      ],
                    ),
                    if( state.status == AudioStatus.pause && state.duration!=null )
                         Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            txt: _printDuration(state.position),
                            ),
                        ),
                        Flexible(
                          child: Slider(
                            min:0 ,
                            max:state.duration !=null ? state.duration!.inMilliseconds.toDouble():0.0 ,
                            value: state.position !=null ? state.position!.inMilliseconds.toDouble():0.0 ,
                            onChanged: (val){
                               
                              durations=Duration(microseconds: (val * 1000).toInt());
                              BlocProvider.of<AudioBlocs>(context).add(Drag(durations));
                            
                          }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                           txt: _printDuration(state.duration)
                            ),
                          
                        ),
                      ],
                    )
                  else if(state.status== AudioStatus.failure && state.duration!=null)
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            txt: _printDuration(state.position),
                            ),
                        ),
                        Flexible(
                          child: Slider(
                            min:0 ,
                            max:state.duration !=null ? state.duration!.inMilliseconds.toDouble():0.0 ,
                            value: state.position !=null ? state.position!.inMilliseconds.toDouble():0.0 ,
                            onChanged: (val){
                              durations=Duration(microseconds: (val * 1000).toInt());
                              BlocProvider.of<AudioBlocs>(context).add(Drag(durations));
                             
                          }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            txt: _printDuration(state.duration),
                            ),
                          
                        ),
                      ],
                    ),

                  SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: ButtonWidget(
                      txt: StringHelp.PICK_AUDIO,
                      press: ()=> permissionUtils.audioPermission(context),
                      ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
