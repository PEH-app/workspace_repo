import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage(
      {required this.departureStation, required this.arrivalStation});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  Set<String> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.departureStation,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
              SizedBox(width: 10),
              Icon(Icons.arrow_circle_right_outlined, size: 30),
              SizedBox(width: 10),
              Text(widget.arrivalStation,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSeatStatus(true, '선택됨'),
                SizedBox(width: 20),
                buildSeatStatus(false, '선택안됨'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildLabel('A'),
              SizedBox(width: 4),
              buildLabel('B'),
              SizedBox(width: 50),
              buildLabel('C'),
              SizedBox(width: 4),
              buildLabel('D'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20, //총 항목 수
              //itemBuilder 는 몇개의 아이템을 만들지 결정하는 함수. 각항목을 생성하는 함수. 두개의 매개변수(빌드컨텍스트와 현재 생성하고 있는 항목의 index)
              itemBuilder: (context, index) {
                final rowNum = index + 1;
                return Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildSeat('$rowNum-A'),
                      SizedBox(width: 4),
                      buildSeat('$rowNum-B'),
                      buildLabel('$rowNum'),
                      buildSeat('$rowNum-C'),
                      SizedBox(width: 4),
                      buildSeat('$rowNum-D'),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed:
                selectedSeats.isNotEmpty ? showBookingConfirmation : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text(
              '예매 하기',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

//좌석 상태 설명
  Widget buildSeatStatus(bool isSelected, String label) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple : Colors.grey[300]!,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }

//A,B,C,D 표시
  Widget buildLabel(String label) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(fontSize: 18)),
    );
  }

//좌석 선택
  Widget buildSeat(String seatNumber) {
    bool isSelected = selectedSeats.contains(seatNumber);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedSeats.remove(seatNumber);
          } else {
            selectedSeats.add(seatNumber);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300]!,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

//예매 확인
  void showBookingConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('예매 하시겠습니까?'),
        content: Text('좌석: ${selectedSeats.join(", ")}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('취소', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 다이얼로그 닫기
              Navigator.pop(context); // SeatPage 닫기
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}
