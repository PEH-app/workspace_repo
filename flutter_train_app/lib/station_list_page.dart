import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title;
  const StationListPage(this.title);
  @override
  Widget build(BuildContext context) {
    // 역 목록 배열 정의
    final List<String> stations = [
      '수서',
      '동탄',
      '평택지제',
      '천안아산',
      '오송',
      '대전',
      '김천구미',
      '동대구',
      '경주',
      '울산',
      '부산',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView(
        children: stations.map((station) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: ListTile(
              title: Text(station,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                // 선택한 역을 이전 페이지로 전달
                Navigator.pop(context, station);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
