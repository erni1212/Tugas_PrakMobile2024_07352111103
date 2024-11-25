import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/detail_screen.dart';
import 'edit_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Data berita statis
  final List<Map<String, String>> news = [
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      'title': 'Russian warship: Moskva sinks in Black Sea',
      'author': 'Wahyu',
      'description': 'Cukup salin salah satu URL di atas dan gunakan sebagai imageUrl di aplikasi Flutter atau HTML <img> tag. Kamu juga bisa mengunduh gambar dari URL tersebut dan menyimpannya untuk digunakan secara offline.',
      'time': '4h ago',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      'title': "Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil",
      'author': 'Wahyu',
      'description': 'Cukup salin salah satu URL di atas dan gunakan sebagai imageUrl di aplikasi Flutter atau HTML <img> tag. Kamu juga bisa mengunduh gambar dari URL tersebut dan menyimpannya untuk digunakan secara offline.',
      'time': '14m ago',
    },
    {
      'imageUrl': 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      'title': "Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil",
      'author': 'Wahyu',
      'description': 'Cukup salin salah satu URL di atas dan gunakan sebagai imageUrl di aplikasi Flutter atau HTML <img> tag. Kamu juga bisa mengunduh gambar dari URL tersebut dan menyimpannya untuk digunakan secara offline.',
      'time': '14m ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Halaman-halaman yang akan ditampilkan di IndexedStack
    final List<Widget> pages = [
      ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: news[index]['title'].toString(),
                      description: news[index]['description'].toString(),
                      imageUrl: news[index]['imageUrl'].toString(),
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), // Add border radius here
                      child: Image.network(
                        news[index]['imageUrl'].toString(), // Accessing imageUrl from News model
                        fit: BoxFit.cover, // Optional: Adjust the fit as needed
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        news[index]['title'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${news[index]['author']} • ${news[index]['time']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      const Center(child: Text('Explore Page')), // Placeholder for Explore Page
      const Center(child: Text('Bookmark Page')), // Placeholder for Bookmark Page
      EditProfileScreen(), // Halaman Profil
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'MY',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'APP',
              style: TextStyle(
                color: Color(0xFFB71C1C),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFB71C1C),
              ),
              child: Text('Pengaturan', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF1F77F2),
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
