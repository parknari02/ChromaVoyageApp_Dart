import 'package:flutter/material.dart';
import './create_group_screen.dart';
import './map_screen.dart';
import '../models/group.dart';
import '../widgets/AddLocationWidget.dart';


// import 'screens/create_group_screen.dart';
// import 'screens/map_screen.dart';
// import 'models/group.dart';

void main() => runApp(MyMain());

class MyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Group> groups = [];

  Future<void> _onItemTapped(int index) async {
    if (index == 2) {
      Group createdGroup = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateGroupScreen(),
        ),
      );

      if (createdGroup != null) {
        setState(() {
          groups.add(createdGroup);
        });
      }
    } else if (index == 0) {  // 'map' 버튼을 눌렀을 때
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyMap(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final PageController _pageController = PageController();

  int _selectedIndex = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 250, 250), // Set background color to white
          elevation: 0, // Set elevation to 0 for no shadow
          title: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFFB28EFF),
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '박나리님',
                style: TextStyle
                ( color: Color(0xFF6540B4) ,
                  fontSize: 14), // Adjust font size as needed
              ),
            ],
          ),
          actions: [ 
            IconButton(
              icon: Icon(Icons.menu, color: Color(0xFF6540B4), size: 30),
              onPressed: () {
                // Add your logic for the menu icon press
              },
            ),
          ],
        ),
        
        body: 
        
        
        ListView.builder(
  itemCount: groups.length,
  itemBuilder: (context, index) {
    return Container(
      height: 85, // Adjust the height as needed
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Color(0xFFB28EFF)), // 조절 가능한 모서리 반지름
        ),
        child: ListTile(
          title: Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              groups[index].groupName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                
              ),
            ),
          ),
          
          subtitle: Row(
            children: [
              CircleAvatar(
                radius: 11,
                backgroundColor: Color(0xFF6540B4),
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Text(groups[index].invitedPeople.first),
              SizedBox(width: 2),
              Text('외 ${groups[index].invitedPeople.length - 1}명'),
            ],
          ),
          
          trailing: Column(
  mainAxisAlignment: MainAxisAlignment.end,
  mainAxisSize: MainAxisSize.min, // Set mainAxisSize to MainAxisSize.min
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    IconButton(
      icon: Icon(Icons.close, size: 14),
      onPressed: () {
        // Add your logic for 'x' button press
      },
    ),
  ],
),
          
          onTap: () {
            // 원하는 동작 추가
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddLocation(),
              ),
            );
          },
        ),
      ),
    );
  },
),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'add',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          backgroundColor: Color(0xFF6540B4),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

