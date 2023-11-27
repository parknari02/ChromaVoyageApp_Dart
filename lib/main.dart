import 'package:chromavoyage_client/screens/create_group_screen.dart';
import 'package:chromavoyage_client/widgets/AddLocationWidget.dart';
import 'package:flutter/material.dart';
import 'screens/map_screen.dart';
import 'models/group.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _title = 'Flutter SketchApp';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
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
        body: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(groups[index].groupName),
              subtitle: Text(groups[index].invitedPeople.join(', ')),
              onTap: () {
                // 원하는 동작 추가
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLocation(),
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_cloudy),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'add',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.deepPurple[200],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   final _title = 'Flutter SketchApp';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: const MyStatefulWidget(),
//     );
//   }
// }

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => MyStatefulWidgetState();

  
// }

// class MyStatefulWidgetState extends State<MyStatefulWidget> {
//     List<Group> groups = [];
    

//   Future<void> _onItemTapped(int index) async {
//     if (index == 2) { // 'add' 버튼을 눌렀을 때
//       Group createdGroup = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CreateGroupScreen(),
//         ),
//       );

//       // Check if the createdGroup is not null and add it to the list
//       if (createdGroup != null) {
//         setState(() {
//           groups.add(createdGroup);
//           print(createdGroup.groupName);
          
//         });
//       }
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }
//   final PageController _pageController = PageController();

//   int _selectedIndex = 1;

//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       '나중에 지도페이지',
//       style: optionStyle,
//     ),
//     Text(
//       '홈화면임',
//       style: optionStyle,
//     ),
//     Text(
//       'Star',
//       style: optionStyle,
//     ),
//   ];

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
  





  
//   void returnToMain(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     Navigator.pop(context);
//   }

//   @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     home: Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Flutter Sketch Application'),
//       // ),
//       body: PageView(
//         controller: _pageController,
//         children: <Widget>[
//           Scaffold(
//             body: Center(
//               child: _widgetOptions.elementAt(_selectedIndex),
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               items: const <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'map',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.wb_cloudy),
//                   label: 'home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.star),
//                   label: 'add',
//                 ),
//               ],
//               currentIndex: _selectedIndex,
//               selectedItemColor: Colors.white,
//               backgroundColor: Colors.deepPurple[200],
//               onTap: _onItemTapped,
//             ),
//           ),
          
//         ],
//       ),
//       // Drawer를 여기에 추가
//        drawer: Drawer(
//         child: ListView.builder(
//           itemCount: groups.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(groups[index].groupName),
//               subtitle: Text(groups[index].invitedPeople.join(', ')),
//               onTap: () {
//                 // 원하는 동작 추가
//               },
//             );
//           },
//         ),
//       ),
      
//     ),
//   );
// }
// }