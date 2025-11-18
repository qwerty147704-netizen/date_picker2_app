import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String currentDateTime; // 현재 시간
  late bool _isRunning; // 현재시간용 타이머 중단수단
  DateTime? chosenDateTime; // 초기값 설정 불가

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDateTime = '';
    _isRunning = true;

    Timer.periodic(Duration(seconds: 1), (timer){
      if(!_isRunning){
        timer.cancel();
      }
      _addItem();
      setState(() {});
      }
    );
  }

  _addItem(){ // 윗줄 currentDateTime을 Timer로 띄우는 함수
    DateTime now = DateTime.now();
    currentDateTime = ('${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${_weekdayToString(now.weekday)} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}');
  }

  String _weekdayToString(int weekday){ // now.weekday를 한글 요일로 변환하는 함수
    String dateName = '';
    switch(weekday){
      case 1: dateName = '월';
      case 2: dateName = '화';
      case 3: dateName = '수';
      case 4: dateName = '목';
      case 5: dateName = '금';
      case 6: dateName = '토';
      case 7: dateName = '일';
    }
    return dateName;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('현재 시간: $currentDateTime',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(
              width: 380,
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                use24hFormat: true,
                onDateTimeChanged: (value) {
                  chosenDateTime = value;
                  setState(() {});
                },
              ),
            ),
            Text(
              '선택 시간: ${chosenDateTime != null ? _chosenItem(chosenDateTime!) : '시간을 선택하세요!'}', // chosendatetime: 선택 전이라 initstate 설정 불가
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                )
            )
          ],
        ),
      ),
    );
  } // build
  // ----- Functions -----
  String _chosenItem(DateTime now){
    String chosenDateTime = ('${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${_weekdayToString(now.weekday)} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}');
    return chosenDateTime;
  }
}