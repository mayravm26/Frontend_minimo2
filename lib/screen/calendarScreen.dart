import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  List<Map<String, dynamic>> _events = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = _selectedDay;
    fetchEventsFromDatabase();
  }

  // Obté els esdeveniments des de la base de dades
  void fetchEventsFromDatabase() async {
    // Aquesta funció hauria d'obtindre esdeveniments reals des de la teva base de dades
    setState(() {
      _events = []; // Substitueix per dades reals de la base de dades
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCE6E6), // Color de fons general
      appBar: AppBar(
        title: Text("Calendari"),
        backgroundColor: Color(0xFF89AFAF), // Color de la barra superior
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16), // Separació amb el calendari
            // Calendari
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFB2D5D5), // Color del fons del calendari
                borderRadius: BorderRadius.circular(12), // Corbes suaus
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 01, 01),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                startingDayOfWeek: StartingDayOfWeek.monday, // Setmana comença dilluns
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF89AFAF), // Color del dia seleccionat
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 31, 130, 130), // Color del dia d'avui
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false, // Amagar dies fora del mes
                  cellMargin: EdgeInsets.all(6), // Separació entre cel·les
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.black),
                  weekendStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Llista d'esdeveniments
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFB2D5D5), // Color del fons
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pròxims esdeveniments",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: _events.isEmpty
                          ? Center(
                              child: Text(
                                "No hi ha esdeveniments pròxims.",
                                style: TextStyle(color: Colors.black54),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _events.length,
                              itemBuilder: (context, index) {
                                final event = _events[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    event['title'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(event['location']),
                                  trailing: Text(
                                    "${event['date'].day}/${event['date'].month}/${event['date'].year}",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acció per afegir un nou esdeveniment
        },
        backgroundColor: Color(0xFF89AFAF),
        child: Icon(Icons.add),
      ),
    );
  }
}
