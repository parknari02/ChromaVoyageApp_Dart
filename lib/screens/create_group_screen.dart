import 'package:flutter/material.dart';
import '../models/group.dart';


class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController invitedPersonController = TextEditingController();
  List<Group> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: groupNameController,
              decoration: InputDecoration(labelText: 'Group Name'),
            ),
            TextField(
              controller: invitedPersonController,
              decoration: InputDecoration(labelText: 'Invited Person'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                createGroup();
              },
              child: Text('Create Group'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(groups[index].groupName),
                      subtitle: Text(groups[index].invitedPeople.join(', ')),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createGroup() {
    setState(() {
      String groupName = groupNameController.text;
      String invitedPerson = invitedPersonController.text;
      List<String> invitedPeople = invitedPerson.split(',');

      Group newGroup = Group(groupName, invitedPeople);
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
