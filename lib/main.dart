import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const ResourceView());

class ResourceView extends StatefulWidget {
  const ResourceView({super.key});

  @override
  ResourceViewState createState() => ResourceViewState();
}

class ResourceViewState extends State<ResourceView> {
  List<Appointment> _shiftCollection = <Appointment>[];
  final List<CalendarResource> _employeeCollection = <CalendarResource>[];
  late _DataSource _events;

  @override
  void initState() {
    _addResources();
    _addAppointments();
    _events = _DataSource(_shiftCollection, _employeeCollection);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SfCalendar(
            view: CalendarView.timelineWeek,
            allowedViews: const [
              CalendarView.timelineDay,
              CalendarView.timelineWeek,
              CalendarView.timelineWorkWeek,
            ],
            showDatePickerButton: true,
            resourceViewSettings: const ResourceViewSettings(
                displayNameTextStyle: TextStyle(color: Colors.white),
                showAvatar: false,
                size: 120,
                visibleResourceCount: 5),
            dataSource: _events,
          ),
        ),
      ),
    );
  }

  void _addResources() {
    Random random = Random();
    List<String> nameCollection = <String>[];
    nameCollection.add('John');
    nameCollection.add('Bryan');
    nameCollection.add('Robert');
    nameCollection.add('Kenny');
    nameCollection.add('Tia');
    nameCollection.add('Theresa');
    nameCollection.add('Edith');
    nameCollection.add('Brooklyn');
    nameCollection.add('James William');
    nameCollection.add('Sophia');
    nameCollection.add('Elena');
    nameCollection.add('Stephen');
    nameCollection.add('Zoey Addison');
    nameCollection.add('Daniel');
    nameCollection.add('Emilia');
    nameCollection.add('Kinsley Elena');
    nameCollection.add('Daniel');
    nameCollection.add('William');
    nameCollection.add('Addison');
    nameCollection.add('Ruby');

    List<Color> resourceColorCollection = <Color>[];
    resourceColorCollection.add(const Color(0xFF7c9473));
    resourceColorCollection.add(const Color(0xFFcfdac8));
    resourceColorCollection.add(const Color(0xFFcdd0cb));
    resourceColorCollection.add(const Color(0xFF9dad7f));

    for (int i = 0; i < nameCollection.length; i++) {
      _employeeCollection.add(CalendarResource(
        displayName: nameCollection[i],
        id: '000$i',
        color: resourceColorCollection[random.nextInt(4)],
      ));
    }
  }

  void _addAppointments() {
    _shiftCollection = <Appointment>[];
    List<String> subjectCollection = <String>[];
    subjectCollection.add('General Meeting');
    subjectCollection.add('Plan Execution');
    subjectCollection.add('Project Plan');
    subjectCollection.add('Consulting');
    subjectCollection.add('Support');
    subjectCollection.add('Development Meeting');
    subjectCollection.add('Scrum');
    subjectCollection.add('Project Completion');
    subjectCollection.add('Release updates');
    subjectCollection.add('Performance Check');

    List<Color> colorCollection = <Color>[];
    colorCollection.add(const Color(0xFFbe9fe1));
    colorCollection.add(const Color(0xFFc9b6e4));
    colorCollection.add(const Color(0xFFe1ccec));
    colorCollection.add(const Color(0xFFf1f1f6));

    final Random random = Random();
    for (int i = 0; i < _employeeCollection.length; i++) {
      final List<String> employeeIds = <String>[_employeeCollection[i].id.toString()];
      if (i == _employeeCollection.length - 1) {
        int index = random.nextInt(5);
        index = index == i ? index + 1 : index;
        employeeIds.add(_employeeCollection[index].id.toString());
      }

      for (int k = 0; k < 365; k++) {
        if (employeeIds.length > 1 && k % 2 == 0) {
          continue;
        }
        for (int j = 0; j < 2; j++) {
          final DateTime date = DateTime.now().add(Duration(days: k + j));
          int startHour = 9 + random.nextInt(6);
          startHour =
          startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
          final DateTime shiftStartTime =
          DateTime(date.year, date.month, date.day, startHour, 0, 0);
          _shiftCollection.add(Appointment(
              startTime: shiftStartTime,
              endTime: shiftStartTime.add(const Duration(hours: 1)),
              subject: subjectCollection[random.nextInt(8)],
              color: colorCollection[random.nextInt(4)],
              resourceIds: employeeIds));
        }
      }
    }
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}