import 'package:flutter/material.dart';

void main() {
  return runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Title merupakan nama dari aplikasi kita
      title: "Praktikum 01",
      theme: ThemeData(
        //Untuk mengatur tema light pada aplikasi
        colorScheme: ColorScheme.light(
          //Warna primary pada aplikasi
          //Apabila ingin menggunakan warna lain bisa menggunakan hexcode
          //Dengan cara Color(0xFF"warna hexa yang kalian inginkan")
          primary: Colors.red,
        ),
      ),
      //Halaman pertama yang akan terbuka saat aplikasi dijalankan/ di compile
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Praktikum 01"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              'assets/user_img.png',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Nama"),
              Text(":"),
              SizedBox(width: 100),
              Text("Neuvilette"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Email"),
              Text(":"),
              SizedBox(width: 100),
              Text("Neuvilette@Gmail.com"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("NIM"),
              Text(":"),
              SizedBox(width: 100),
              Text("20200801177"),
            ],
          ),
        ],
      ),
    );
  }
}
