// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/bloc/audio_blocs/audio_state.dart';
import 'package:task4/bloc/audio_blocs/audio_bloc.dart';
import 'package:task4/bloc/audio_blocs/audio_events.dart';
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
  double val=0.0;
  late Timer? timer;

  @override
  void initState() {
   timer= Timer.periodic(Duration(seconds: 1), (Timer t) => BlocProvider.of<AudioBlocs>(context).add(GetDuration()));
    super.initState();
  }          
    @override
  void didChangeDependencies() {
   
    super.didChangeDependencies();
    
    BlocProvider.of<AudioBlocs>(context).add(Closed());
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(title: TextWidget(txt:StringHelp.AUDIO_SCREEN),),
      
      body: Center(
        child: BlocBuilder<AudioBlocs, AudioStates>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(state.status == AudioStatus.success)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(txt: state.position.inSeconds.toString()),
                        ),
                        Flexible(
                          child: Slider(
                            min:0 ,
                            max:state.duration.inSeconds.toDouble() ,
                            value: state.position.inSeconds.toDouble(), 
                            onChanged: (_){
                          }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(txt: state.duration.inSeconds.toString()),
                          
                        ),
                      ],
                    )
                  else if(state.status== AudioStatus.initial)
                    TextWidget(txt:StringHelp.NO_FILE)
                  else if(state.status== AudioStatus.initial)
                    TextWidget(txt: StringHelp.ERROR_TEXT),

                  SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: ButtonWidget(
                      txt: StringHelp.PICK_AUDIO,
                      press: (){
                        BlocProvider.of<AudioBlocs>(context)
                                .add(FetchAudio());
                      }),
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
