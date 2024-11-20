import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat_page.dart';
import 'package:flutter_train_app/station_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedDepartureStation;
  String? selectedArrivalStation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기차 예매'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: rowBox()),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    if (selectedDepartureStation != null &&
                        selectedArrivalStation != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatPage(
                            departureStation: selectedDepartureStation!,
                            arrivalStation: selectedArrivalStation!,
                          ),
                        ),
                      );
                    } else {
                      // 출발역과 도착역이 선택되지 않았을 때 경고 메시지 출력
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('출발역과 도착역을 모두 선택해주세요.')),
                      );
                    }
                  },
                  child: Text(
                    '좌석 선택',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

// 역 선택 박스
  Widget rowBox() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        StationListPage('출발역')), // StationListPage로 이동
              );
              setState(() {
                selectedDepartureStation = result; // 선택된 출발역 저장
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '출발역',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                  selectedDepartureStation ?? '선택',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: VerticalDivider(
            color: Colors.grey[400],
            thickness: 2,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        StationListPage('도착역')), // StationListPage로 이동
              );
              setState(() {
                selectedArrivalStation = result; // 선택된 도착역 저장
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '도착역',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                  selectedArrivalStation ?? '선택',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
