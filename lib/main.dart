import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title merupakan nama dari aplikasi kita
      title: "Praktikum 02",
      theme: _isDarkMode ? darkTheme : lightTheme,
      // Halaman pertama yang akan terbuka saat aplikasi dijalankan/ di compile
      home: Scaffold(
        appBar: AppBar(
          title: Text("Praktikum 02"),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            HomeScreen(),
            SecondTab(),
          ],
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: _isDarkMode ? Colors.blue : Colors.red,
          ),
          unselectedLabelColor:
              _isDarkMode ? Colors.blueAccent : Colors.redAccent,
          tabs: [
            Tab(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  Text('Home'),
                ],
              ),
            ),
            Tab(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings),
                  Text('Settings'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final ThemeData lightTheme = ThemeData(
  // Untuk mengatur tema light pada aplikasi
  colorScheme: ColorScheme.light(
    // Warna primary pada aplikasi
    // Apabila ingin menggunakan warna lain bisa menggunakan hexcode
    // Dengan cara Color(0xFF"warna hexa yang kalian inginkan")
    primary: Colors.red,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.red, // Background color for light mode AppBar
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  // Untuk mengatur tema dark pada aplikasi
  colorScheme: ColorScheme.dark(
    // Warna primary pada aplikasi dalam dark mode
    // Apabila ingin menggunakan warna lain bisa menggunakan hexcode
    // Dengan cara Color(0xFF"warna hexa yang kalian inginkan")
    primary: Colors.blue,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue, // Background color for dark mode AppBar
  ),
);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        CircleAvatar(
          backgroundColor: Colors.black87,
          radius: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/user_img.png'),
              backgroundColor: Colors.white70,
              radius: 120,
            ),
          ),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Nama"),
          subtitle: Text("Neuvilette"),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text("Email"),
          subtitle: Text("Neuvilette@Gmail.com"),
        ),
        ListTile(
          leading: Icon(Icons.confirmation_number),
          title: Text("NIM"),
          subtitle: Text("20200801177"),
        ),
      ],
    );
  }
}

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnotherPage()),
              );
            },
            child: Text('Go to Another Page'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _launchPhone();
            },
            child: Text('Open Phone'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _launchBrowser();
            },
            child: Text('Open Web Browser'),
          ),
        ],
      ),
    );
  }

  // Function to launch phone
  void _launchPhone() async {
    const url = 'tel:+1234567890'; // Change to your phone number
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to launch web browser
  void _launchBrowser() async {
    const url = 'https://www.example.com'; // Change to your URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}



class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Text('This is another page'),
      ),
    );
  }
}
