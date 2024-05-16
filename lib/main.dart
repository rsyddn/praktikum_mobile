import 'package:flutter/material.dart';
import 'package:praktikum_mobile/location_utils.dart';

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
      title: "Praktikum Mobile - Flutter",
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
            ProfileScreen(),
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
                  Icon(Icons.person),
                  Text('Profile'),
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

class ProfileScreen extends StatelessWidget {
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
          trailing: Icon(Icons.edit),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text("Email"),
          subtitle: Text("Neuvilette@Gmail.com"),
          trailing: Icon(Icons.edit),
        ),
        ListTile(
          leading: Icon(Icons.confirmation_number),
          title: Text("NIM"),
          subtitle: Text("20200801177"),
          trailing: Icon(Icons.edit),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: [
            buildCard(
              context,
              'Persegi',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SisiPersegiScreen()),
                );
              },
            ),
            buildCard(
              context,
              'Persegi Panjang',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SisiPersegiPanjangScreen(),
                  ),
                );
              },
            ),
            buildCard(
              context,
              'Bangun Segitiga',
              () {
                // Add onTap logic for third button
              },
            ),
            buildCard(
              context,
              'Bangun Lingkaran',
              () {
                // Add onTap logic for fourth button
              },
            ),
            buildCard(
              context,
              'Get Location',
              () async {
                LocationUtils utils = LocationUtils();
                final result = await utils.streamLocation();
                result?.listen((event) {
                  print("Latitude: ${event.latitude}");
                  print("Longitude: ${event.longitude}");
                });
                result?.drain();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.red,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SisiPersegiScreen extends StatefulWidget {
  const SisiPersegiScreen({super.key});

  @override
  State<SisiPersegiScreen> createState() => _SisiPersegiScreenState();
}

class _SisiPersegiScreenState extends State<SisiPersegiScreen> {
  int sisi = 0;
  int value = 0;
  bool isCalculated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persegi'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text("Masukan Nilai Sisi Persegi"),
                subtitle: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (!isCalculated) {
                      sisi = int.parse(value);
                    } else {
                      value = '';
                    }
                  },
                ),
              ),
              ListTile(
                title: Text('Nilai Luas: $value'),
              ),
              SizedBox(height: 10),
              !isCalculated
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          value = sisi * sisi;
                          isCalculated = true;
                          print(value);
                        });
                      },
                      child: Text('Calculate'),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    value = 0;
                    sisi = 0;
                    isCalculated = false;
                    print(value);
                    print(sisi);
                  });
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SisiPersegiPanjangScreen extends StatefulWidget {
  const SisiPersegiPanjangScreen({super.key});

  @override
  State<SisiPersegiPanjangScreen> createState() =>
      _SisiPersegiPanjangScreenState();
}

class _SisiPersegiPanjangScreenState extends State<SisiPersegiPanjangScreen> {
  int panjang = 0;
  int lebar = 0;
  int value = 0;
  bool isCalculated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persegi Panjang'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text("Masukan Nilai Panjang"),
                subtitle: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (!isCalculated) {
                      panjang = int.parse(value);
                    } else {
                      value = '';
                    }
                  },
                ),
              ),
              ListTile(
                title: Text("Masukan Nilai Lebar"),
                subtitle: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (!isCalculated) {
                      lebar = int.parse(value);
                    } else {
                      value = '';
                    }
                  },
                ),
              ),
              ListTile(
                title: Text('Nilai Luas: $value'),
              ),
              SizedBox(height: 10),
              !isCalculated
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          value = panjang * lebar;
                          isCalculated = true;
                          print(value);
                        });
                      },
                      child: Text('Calculate'),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    value = 0;
                    panjang = 0;
                    lebar = 0;
                    isCalculated = false;
                    print(value);
                    print(panjang);
                    print(lebar);
                  });
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
