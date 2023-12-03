import 'package:flutter/material.dart';
import 'map_screen.dart';
import '../main.dart';
import '../models/group.dart';


class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController invitedPersonController = TextEditingController();
  List<Group> groups = [];

  Future<void> _onItemTapped(int index) async {
  if (index == 0) {  // 'map' 버튼을 눌렀을 때
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyMap(),
      ),
    );
  }

  else if (index == 1){
    Navigator.pop(context);
  } 
  
  else {
    setState(() {
      _selectedIndex = index;
    });
  }
}

  final PageController _pageController = PageController();

  int _selectedIndex = 2;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: groupNameController,
              decoration: InputDecoration(labelText: '그룹 이름'),
            ),
            TextField(
              controller: invitedPersonController,
              decoration: InputDecoration(labelText: '초대할 사람'),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                createGroup();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF6540B4), // 색상을 보라색으로 변경
              ),
              child: Text(
                '그룹 만들기',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // 텍스트를 굵게 변경
                ),
              ),
            ),
            SizedBox(height: 20),
//             Expanded(
//   child: ListView.builder(
//     itemCount: groups.length,
//     itemBuilder: (context, index) {
//       return Card(
//         child: ListTile(
//           title: Text(
//             groups[index].groupName,
//             style: TextStyle(color: Colors.black), // 검정색으로 변경
//           ),
//           subtitle: Text(
//             groups[index].invitedPeople.join(', '),
//             style: TextStyle(color: Colors.black), // 검정색으로 변경
//           ),
//         ),
//       );
//     },
//   ),
// ),
          ],
        ),
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
    );
  }

  void createGroup() {
    setState(() {
      String groupName = groupNameController.text;
      String invitedPerson = invitedPersonController.text;
      int groupId = 9999;
      List<String> invitedPeople = invitedPerson.split(',');

      Group newGroup = Group(groupName, invitedPeople, groupId);
      groups.add(newGroup);

      // Clear the text fields
      groupNameController.clear();
      invitedPersonController.clear();

      print('Create Group: $newGroup');

      // Pass the created group back to the main screen
      Navigator.pop(context, newGroup);
    });
  }
}
