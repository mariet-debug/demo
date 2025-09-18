import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MainPage(),
    );
  }
}

// ---------------- MAIN PAGE WITH BOTTOM NAV ----------------
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const LeadsPage(),
    const StatusPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Leads"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Status"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ---------------- HOME PAGE ----------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Hi Prijith",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Switch + New Leads
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "New Leads",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Switch(value: true, onChanged: (v) {}),
              ],
            ),
            const SizedBox(height: 10),

            // Sales & Cold Leads Cards
            Row(
              children: [
                Expanded(
                    child: _infoCard("Sales closed today", "14", Colors.green)),
                const SizedBox(width: 12),
                Expanded(child: _infoCard("Cold leads", "2", Colors.orange)),
              ],
            ),
            const SizedBox(height: 16),

            // Payment Info
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _circleInfo("Payment links", "14", Colors.purple),
                _circleInfo("Partial Payment", "4", Colors.red),
                _circleInfo("Expected sale", "₹1,10,000", Colors.green),
                _circleInfo("Actual Sale", "₹80,000", Colors.orange),
                _circleInfo("Pending target", "₹1,10,000", Colors.blueGrey),
                _circleInfo("Performance", "90%", Colors.green),
              ],
            ),
            const SizedBox(height: 20),

            // Chart box
            _chartBox("Performance", "90%"),
            const SizedBox(height: 20),
            //chart box2
            _chartBox2('This Month', '₹36,000'),
          ],
        ),
      ),
    );
  }
}

// ---------------- Helper Widgets ----------------

Widget _infoCard(String title, String value, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(value,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: color)),
      ],
    ),
  );
}

Widget _circleInfo(String title, String value, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: color.withOpacity(0.15),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(title, style: const TextStyle(fontSize: 12)),
    ],
  );
}

Widget _chartBox(String title, String value) {
  final bool isPercent = value.contains('%');

  final List<FlSpot> percentSpots = const [
    FlSpot(0, 20),
    FlSpot(1, 40),
    FlSpot(2, 90),
    FlSpot(3, 55),
    FlSpot(4, 65),
  ];
  final List<FlSpot> moneySpots = const [
    FlSpot(0, 8000),
    FlSpot(1, 16000),
    FlSpot(2, 36000),
    FlSpot(3, 30000),
    FlSpot(4, 34000),
  ];

  final spots = isPercent ? percentSpots : moneySpots;
  final double maxY = isPercent ? 100 : 40000;

  return Container(
    height: 180,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double highlightCenterX = (2 / 4) * constraints.maxWidth;
              const double highlightWidth = 56.0;

              return Stack(
                children: [
                  Positioned(
                    left: highlightCenterX - highlightWidth / 2,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: highlightWidth,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: 4,
                        minY: 0,
                        maxY: maxY,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              getTitlesWidget: (value, meta) {
                                const style = TextStyle(fontSize: 10);
                                switch (value.toInt()) {
                                  case 0:
                                    return const Text('Jan', style: style);
                                  case 1:
                                    return const Text('Feb', style: style);
                                  case 2:
                                    return const Text('Mar', style: style);
                                  case 3:
                                    return const Text('Apr', style: style);
                                  case 4:
                                    return const Text('May', style: style);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 3,
                            dotData: FlDotData(
                              show: true,
                              checkToShowDot: (spot, barData) => spot.x == 2,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: spot.x == 2 ? 5 : 3,
                                  color:
                                      spot.x == 2 ? Colors.white : Colors.green,
                                  strokeWidth: spot.x == 2 ? 3 : 0,
                                  strokeColor: Colors.green,
                                );
                              },
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.green.withOpacity(0.25),
                                  Colors.green.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      ],
    ),
  );
}

/////////////////////////////////////////////////////////////
Widget _chartBox2(String title, String value) {
  final bool isPercent = value.contains('₹');

  final List<FlSpot> percentSpots = const [
    FlSpot(0, 20),
    FlSpot(1, 40),
    FlSpot(2, 90),
    FlSpot(3, 55),
    FlSpot(4, 65),
  ];
  final List<FlSpot> moneySpots = const [
    FlSpot(0, 8000),
    FlSpot(1, 16000),
    FlSpot(2, 36000),
    FlSpot(3, 30000),
    FlSpot(4, 34000),
  ];

  final spots = isPercent ? percentSpots : moneySpots;
  final double maxY = isPercent ? 100 : 40000;

  return Container(
    height: 180,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double highlightCenterX = (2 / 4) * constraints.maxWidth;
              const double highlightWidth = 56.0;

              return Stack(
                children: [
                  Positioned(
                    left: highlightCenterX - highlightWidth / 2,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: highlightWidth,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: 4,
                        minY: 0,
                        maxY: maxY,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              getTitlesWidget: (value, meta) {
                                const style = TextStyle(fontSize: 10);
                                switch (value.toInt()) {
                                  case 0:
                                    return const Text('Jan', style: style);
                                  case 1:
                                    return const Text('Feb', style: style);
                                  case 2:
                                    return const Text('Mar', style: style);
                                  case 3:
                                    return const Text('Apr', style: style);
                                  case 4:
                                    return const Text('May', style: style);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 3,
                            dotData: FlDotData(
                              show: true,
                              checkToShowDot: (spot, barData) => spot.x == 2,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: spot.x == 2 ? 5 : 3,
                                  color:
                                      spot.x == 2 ? Colors.white : Colors.green,
                                  strokeWidth: spot.x == 2 ? 3 : 0,
                                  strokeColor: Colors.green,
                                );
                              },
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.green.withOpacity(0.25),
                                  Colors.green.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------- NOTIFICATIONS PAGE ----------------
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 12),
              const Text("Congrats! New Lead Received!",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
              const SizedBox(height: 8),
              const Text("Now let’s convert it.",
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("→"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> leads = [
      "Justin Varghese",
      "Rahul Mehta",
      "Anjali Sharma",
      "Amit Kumar",
      "Sneha Rao"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: leads.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: const Text("New Lead"),
            subtitle: Text(leads[index]),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8)),
              child: const Text("New",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold)),
            ),
            onTap: () => _showPopup(context),
          );
        },
      ),
    );
  }
}
// ============================================================================
// =============================== LEADS PAGE =================================
// ============================================================================

class LeadsPage extends StatefulWidget {
  const LeadsPage({Key? key}) : super(key: key);

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  bool isSearching = false;
  final List<String> leads = List.generate(5, (_) => 'Jestin Varghese');
  String? selectedStatus;

  void _addNewLead(String name) {
    setState(() => leads.insert(0, name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leads', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() => isSearching = !isSearching);
            },
          ),
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black),
              onPressed: () => _showFilterSheet(context),
            ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              final result = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateLeadPage(),
                ),
              );
              if (result != null && result.isNotEmpty) {
                _addNewLead(result);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (isSearching)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: leads.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LeadDetailsPage(name: leads[index]),
                      ),
                    );
                  },
                  child: LeadCard(
                    name: leads[index],
                    date: 'Created on 18-10-2021',
                    onStatusSelected: (val) {
                      setState(() => selectedStatus = val);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: 'Leads'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // ---------------- Filter Bottom Sheet ----------------
  void _showFilterSheet(BuildContext context) {
    DateTime? startDate;
    DateTime? endDate;
    String? selectedLeadStatus;

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (ctx, setSheet) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Filter',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Start Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setSheet(() => startDate = picked);
                    },
                    controller: TextEditingController(
                      text: startDate == null
                          ? ''
                          : '${startDate!.day}/${startDate!.month}/${startDate!.year}',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'End Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setSheet(() => endDate = picked);
                    },
                    controller: TextEditingController(
                      text: endDate == null
                          ? ''
                          : '${endDate!.day}/${endDate!.month}/${endDate!.year}',
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      _showStatusSheet(context, (_) {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        selectedLeadStatus ?? 'Lead Status',
                        style: TextStyle(
                          color: selectedLeadStatus == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setSheet(() {
                              startDate = null;
                              endDate = null;
                              selectedLeadStatus = null;
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text('Search'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ============================================================================
// ============================== CREATE LEAD PAGE =============================
// ============================================================================

class CreateLeadPage extends StatefulWidget {
  const CreateLeadPage({Key? key}) : super(key: key);

  @override
  State<CreateLeadPage> createState() => _CreateLeadPageState();
}

class _CreateLeadPageState extends State<CreateLeadPage> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final qualCtrl = TextEditingController();
  late final String dateText;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    dateText =
        '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Create Lead', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Date'),
              controller: TextEditingController(text: dateText),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: qualCtrl,
              decoration: const InputDecoration(labelText: 'Qualification'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(14)),
                onPressed: () {
                  if (nameCtrl.text.isNotEmpty) {
                    Navigator.pop(context, nameCtrl.text);
                  }
                },
                child: const Text('Create'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// ============================================================================
// =============================== Lead Card ==================================
// ============================================================================

class LeadCard extends StatefulWidget {
  final String name;
  final String date;
  final ValueChanged<String?> onStatusSelected;

  const LeadCard({
    Key? key,
    required this.name,
    required this.date,
    required this.onStatusSelected,
  }) : super(key: key);

  @override
  State<LeadCard> createState() => _LeadCardState();
}

class _LeadCardState extends State<LeadCard> {
  String? status;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(widget.date,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'New Lead',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.facebook, size: 20, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildActionButton(Icons.mobile_friendly_rounded, Colors.teal),
                _buildActionButton(Icons.phone, Colors.orange),
                _buildActionButton(Icons.email, Colors.blue),
              ],
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _showStatusSheet(context, (val) {
                setState(() => status = val);
                widget.onStatusSelected(val);
              }),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status ?? 'Status',
                  style: TextStyle(
                    color: status == null ? Colors.grey : Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: color),
    );
  }
}

// ============================================================================
// ========================== Status & Payment Popups =========================
// ============================================================================

void _showStatusSheet(BuildContext context, ValueChanged<String?> onSelected) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    context: context,
    builder: (ctx) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Phone Switched Off'),
            onTap: () {
              onSelected('Phone Switched Off');
              Navigator.pop(ctx);
            },
          ),
          ListTile(
            title: const Text('Didn\'t Pickup'),
            onTap: () {
              onSelected('Didn\'t Pickup');
              Navigator.pop(ctx);
            },
          ),
          ListTile(
            title: const Text('Success'),
            onTap: () {
              Navigator.pop(ctx);
              _showPaymentSheet(context, onSelected);
            },
          ),
          ListTile(
            title: const Text('Option 4'),
            onTap: () {
              onSelected('Option 4');
              Navigator.pop(ctx);
            },
          ),
        ],
      );
    },
  );
}

void _showPaymentSheet(BuildContext context, ValueChanged<String?> onSelected) {
  String? selectedPayment;
  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setSheet) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Change Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: selectedPayment == 'Full',
                  title: const Text('Full Payment'),
                  onChanged: (_) => setSheet(() => selectedPayment = 'Full'),
                ),
                CheckboxListTile(
                  value: selectedPayment == 'Partial',
                  title: const Text('Partial Payment'),
                  onChanged: (_) => setSheet(() => selectedPayment = 'Partial'),
                ),
                CheckboxListTile(
                  value: selectedPayment == 'Offline',
                  title: const Text('Offline Payment'),
                  onChanged: (_) => setSheet(() => selectedPayment = 'Offline'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          if (selectedPayment != null) {
                            onSelected(selectedPayment);
                          }
                          Navigator.pop(ctx);
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// ============================================================================
// ============================= LEAD DETAILS PAGE ============================
// ============================================================================

class LeadDetailsPage extends StatelessWidget {
  final String name;
  const LeadDetailsPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Lead Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [Icon(Icons.edit, color: Colors.black)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 8),
            Text(name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconBtn(Icons.phone_callback_outlined, Colors.green),
                _iconBtn(Icons.phone, Colors.orange),
                _iconBtn(Icons.email, Colors.blue),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 48)),
              onPressed: () => _showAddNoteSheet(context),
              icon: const Icon(Icons.note_add),
              label: const Text('Add Note  •  Create a quick note'),
            ),
            const SizedBox(height: 20),
            _infoTile('Email', 'markusc@gmail.com'),
            _infoTile('Phone', '+91 9874562310'),
            _infoTile('Qualification', 'Bcom'),
            _infoTile('Place', 'Kollam'),
            _infoTile('Source', 'Instagram'),
            _infoTile('Status', 'Phone Switched Off'),
            _infoTile('Program', 'Python'),
            _infoTile('Payment', 'Partial Payment'),
            _infoTile('Payment Date', '22.02.2022'),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child:
                  Text('Notes', style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 8),
            _noteCard('Note heading', '18-10-2021'),
            _noteCard('Note heading', '18-10-2021'),
          ],
        ),
      ),
    );
  }

  static Widget _iconBtn(IconData icon, Color color) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(.15),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: color),
      );

  static Widget _infoTile(String title, String value) => ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text(title,
            style: const TextStyle(fontSize: 13, color: Colors.grey)),
        subtitle: Text(value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      );

  static Widget _noteCard(String heading, String date) => Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: const Icon(Icons.note, color: Colors.green),
          title: Text(heading),
          subtitle: const Text(
              'Lorem ipsum dolor sit amet bir calamq toche amir sans.'),
          trailing: Text(date,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ),
      );
}
// ============================= ADD NOTE SHEET ===============================
// ============================================================================

void _showAddNoteSheet(BuildContext context) {
  String? noteType;
  final noteController = TextEditingController();
  final now = DateTime.now();
  final dateText =
      '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year} '
      '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    context: context,
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Add Notes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('Call'),
                            onTap: () {
                              noteType = 'Call';
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text('Message'),
                            onTap: () {
                              noteType = 'Message';
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text('Meeting'),
                            onTap: () {
                              noteType = 'Meeting';
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    noteType ?? 'Select Note Type',
                    style: TextStyle(
                      color: noteType == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Enter note here...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(dateText,
                      style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Save Note'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
// =========================== STATUS PAGE ============================

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  bool showSearch = false;
  int currentTab = 0;
  final TextEditingController searchCtrl = TextEditingController();

  void _openFilterSheet() {
    bool fullPayment = false;
    bool partialPayment = true;
    bool offlinePayment = false;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Filter',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                      labelText: 'Product', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                const Text('Payment Type',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                CheckboxListTile(
                  value: fullPayment,
                  title: const Text('Full Payment'),
                  onChanged: (val) {
                    fullPayment = val ?? false;
                    (ctx as Element).markNeedsBuild();
                  },
                ),
                CheckboxListTile(
                  value: partialPayment,
                  title: const Text('Partial Payment'),
                  onChanged: (val) {
                    partialPayment = val ?? false;
                    (ctx as Element).markNeedsBuild();
                  },
                ),
                CheckboxListTile(
                  value: offlinePayment,
                  title: const Text('Offline Payment'),
                  onChanged: (val) {
                    offlinePayment = val ?? false;
                    (ctx as Element).markNeedsBuild();
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancel'))),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Continue')),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          currentTab == 0
              ? 'Follow Up'
              : currentTab == 1
                  ? 'Payment Completed'
                  : 'Sale Closed',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(showSearch ? Icons.close : Icons.search,
                color: Colors.black),
            onPressed: () => setState(() => showSearch = !showSearch),
          ),
          if (showSearch)
            IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.black),
                onPressed: _openFilterSheet),
        ],
      ),
      body: Column(
        children: [
          if (showSearch)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildTab(0, Icons.refresh, 'Follow Up'),
                _buildTab(1, Icons.check_circle, 'Payment'),
                _buildTab(2, Icons.verified, 'Sale'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 3,
              itemBuilder: (ctx, index) {
                if (currentTab == 0) return _leadCard();
                if (currentTab == 1) return _paymentCard(context);
                return _saleClosedCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String label) {
    final selected = index == currentTab;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => currentTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon,
                  color: selected ? Colors.green : Colors.grey, size: 22),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal,
                      color: selected ? Colors.black : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _leadCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Markus Coralo',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            const Text('Product name',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Created on 18-10-2021',
                    style: TextStyle(fontSize: 11, color: Colors.black87),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Partially Paid',
                    style: TextStyle(fontSize: 11, color: Colors.orange),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _actionIcon(Icons.phone_callback_rounded, Colors.green),
                const SizedBox(width: 12),
                _actionIcon(Icons.phone, Colors.orange),
                const SizedBox(width: 12),
                _actionIcon(Icons.email, Colors.blue),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _saleClosedCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Markus Coralo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 4),
            Text('Product name',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            SizedBox(height: 8),
            Text('Email: markusc@gmail.com'),
            Text('Phone number: +91 9876543210'),
            Text('Alt Phone: +91 9876543210'),
            Text('Batch: 2021-2022'),
            Text('Address: House No 336B, Street name, Town, 688866'),
            SizedBox(height: 12),
            Text('Created on 18-10-2021',
                style: TextStyle(fontSize: 11, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color),
    );
  }
}

// ---------- Payment Completed Card ----------
Widget _paymentCard(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.only(bottom: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Markus Coralo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          const Text('Product name',
              style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.email, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text('markusc@gmail.com'),
              SizedBox(width: 12),
              Icon(Icons.phone, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text('+91 9876543210'),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text('Created on 18-10-2021',
                style: TextStyle(fontSize: 11)),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdmissionFormPage(
                      name: 'Markus Coralo',
                    ),
                  ),
                );
                if (result == 2) {
                  final state =
                      context.findAncestorStateOfType<_StatusPageState>();
                  state?.setState(() => state.currentTab = 2);
                }
              },
              child: const Text('Complete Admission'),
            ),
          )
        ],
      ),
    ),
  );
}

// ======================= ADMISSION FORM PAGE =======================

class AdmissionFormPage extends StatelessWidget {
  final String name;
  const AdmissionFormPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final line1Ctrl = TextEditingController();
    final line2Ctrl = TextEditingController();
    final line3Ctrl = TextEditingController();
    final pinCtrl = TextEditingController();
    final altPhoneCtrl = TextEditingController();
    final batchCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(name, style: const TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _textField('Address Line 1', line1Ctrl),
            const SizedBox(height: 12),
            _textField('Address Line 2', line2Ctrl),
            const SizedBox(height: 12),
            _textField('Address Line 3', line3Ctrl),
            const SizedBox(height: 12),
            _textField('Pincode', pinCtrl, keyboard: TextInputType.number),
            const SizedBox(height: 12),
            _textField('Alternate Phone Number', altPhoneCtrl,
                keyboard: TextInputType.phone),
            const SizedBox(height: 12),
            _textField('Batch', batchCtrl),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Form Submitted Successfully')));
                  Navigator.pop(context, 2); // go to Sale Closed tab
                },
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textField(String label, TextEditingController ctrl,
      {TextInputType? keyboard}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// ---------------- PROFILE PAGE ----------------
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: const CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 60, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 15),

            // Name and Email
            const Text("Jane Doe",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text("janedoe@gmail.com",
                style: TextStyle(fontSize: 14, color: Colors.grey)),

            const SizedBox(height: 30),

            // Change Password Button
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              leading: const Icon(Icons.lock, color: Colors.black54),
              title: const Text("Change Password",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text("Secure your account",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage()),
                );
              },
            ),

            const SizedBox(height: 30),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Add logout functionality here
                },
                child: const Text("Logout",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- CHANGE PASSWORD PAGE ----------------
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _handleSubmit() {
    if (_newPasswordController.text == _confirmPasswordController.text &&
        _newPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password changed successfully!"),
          backgroundColor: Colors.green));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Change password info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 5))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Change password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("Change the password you use to sign in.",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),

                  const SizedBox(height: 20),

                  // New Password Field
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "New Password",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Confirm Password Field
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm New Password",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _handleSubmit,
                child: const Text("Submit",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
