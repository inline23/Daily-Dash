import 'package:daily_dash/controllers/project%20cubit/project_cubit_cubit.dart';
import 'package:daily_dash/controllers/project%20cubit/project_cubit_state.dart';
import 'package:daily_dash/views/add_project_screen.dart';
import 'package:daily_dash/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // الافتراضي هو Home
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      // الفهرس 0: تمرير دالة النجاح لترجعنا للـ Home
      AddProjectScreen(
        onProjectAdded: () => _onItemTapped(1), 
      ),

      // الفهرس 1: Home View
      BlocBuilder<ProjectCubit, ProjectCubitState>(
        builder: (context, state) {
          if (state is ProjectCubitLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProjectCubitSuccess) {
            return HomeView(projects: state.projects);
          } else if (state is ProjectCubitFailure) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(
            child: Text('No Projects Yet', style: TextStyle(fontSize: 18)),
          );
        },
      ),

      // الفهرس 2: Calendar
      const Center(child: Text('Calendar Page 🗓️', style: TextStyle(fontSize: 20))),
    ];

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _pages,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
          ],
        ),
      ),
    );
  }
}