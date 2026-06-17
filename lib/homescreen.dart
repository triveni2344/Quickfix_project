
import 'package:flutter/material.dart';
import 'dart:async';

// import 'package:users/categories.dart';
// import 'package:users/models/data.dart';
// import 'package:users/profilescreens/notifications.dart';
// import 'package:users/widgets/profile_details.dart';
import 'package:quickfix_project/categories.dart';
import 'package:quickfix_project/models/data.dart';
import 'package:quickfix_project/profilescreens/notifications.dart';
import 'package:quickfix_project/widgets/profile_details.dart';

class HomeScreen extends StatefulWidget {
  // Add callbacks to receive functions from main.dart
  final ValueChanged<String> onToggleSave;
  final ValueChanged<String> onConfirmBooking;

  const HomeScreen({
    super.key,
    required this.onToggleSave,
    required this.onConfirmBooking,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final PageController _tipPageController;
  Timer? _tipAutoScrollTimer;

  String name = 'Vamsi';

  List<Profile> filteredProfiles = [];

  // Local categories for horizontal list in HomeScreen
  List<CategoryModel> categories = [
    CategoryModel(name: "plumbing", icon: Icons.plumbing),
    CategoryModel(name: "electrical", icon: Icons.electrical_services),
    CategoryModel(name: "carpentry", icon: Icons.handyman),
    CategoryModel(name: "cleaning", icon: Icons.cleaning_services),
    CategoryModel(name: "gardening", icon: Icons.local_florist),
    CategoryModel(name: "Painter", icon: Icons.format_paint),
    CategoryModel(name: "Tution", icon: Icons.arrow_forward_ios_sharp),
    CategoryModel(name: "Driver", icon: Icons.car_repair),
    CategoryModel(name: "Chef", icon: Icons.cookie),
    CategoryModel(name: "Mechanic", icon: Icons.car_crash_outlined),
    CategoryModel(name: "Photographer", icon: Icons.photo_camera),
    CategoryModel(name: "Pest Control", icon: Icons.pest_control_rodent),
    CategoryModel(name: "Laundry", icon: Icons.wash_outlined),
    CategoryModel(name: "Movers & Packers", icon: Icons.monitor_weight),
    CategoryModel(name: "Internet", icon: Icons.wifi), 
    CategoryModel(name: "Coolie", icon: Icons.person_3),
    CategoryModel(name: "Beautician", icon: Icons.person_pin),  ];

 List<Imgs> images=[
    Imgs(inmnm: 'assets/image1.jpg'),
    Imgs(inmnm: 'assets/image2.jpg'),
    Imgs(inmnm: 'assets/image3.jpg'),
    Imgs(inmnm: 'assets/image4.jpg'),
    
 ];

  bool _isSearchExpanded = true;
  bool _isCategoryCollapsed = false;
  late AnimationController _searchAnimController;
  late Animation<double> _searchAnim;

  double getResponsiveValue(BuildContext context, double value) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseWidth = 375.0; // iPhone X width as base
    return (screenWidth / baseWidth) * value;
  }

  double getResponsiveFontSize(BuildContext context, double fontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseWidth = 375.0;
    final scaleFactor = screenWidth / baseWidth;
    return fontSize * scaleFactor.clamp(0.8, 1.3); // Limit scaling
  }

  @override
  void initState() {
    super.initState();
    filteredProfiles = List.from(profilesData);

    _searchAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _searchAnim = CurvedAnimation(
      parent: _searchAnimController,
      curve: Curves.easeInOut,
    );

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      if (offset > 80 && (_isSearchExpanded || !_isCategoryCollapsed)) {
        setState(() {
          _isSearchExpanded = false;
          _isCategoryCollapsed = true;
        });
        _searchAnimController.reverse();
      } else if (offset < 40 && (!_isSearchExpanded || _isCategoryCollapsed)) {
        setState(() {
          _isSearchExpanded = true;
          _isCategoryCollapsed = false;
        });
        _searchAnimController.forward();
      }
    });

    _tipPageController = PageController(viewportFraction: 1.0);
    _tipAutoScrollTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (_tipPageController.hasClients) {
          final page = _tipPageController.page?.toInt() ?? 0;
          final next = (page + 1) % 5;
          _tipPageController.animateToPage(
            next,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      },
    );
    _searchAnimController.forward();
  }

  @override
  void dispose() {
    _searchAnimController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    _tipPageController.dispose();
    _tipAutoScrollTimer?.cancel();
    super.dispose();
  }

  void filterProfiles(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProfiles = List.from(profilesData);
      } else {
        filteredProfiles = profilesData
            .where((profile) =>
                profile.name.toLowerCase().contains(query.toLowerCase()) ||
                profile.category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Widget _buildFloatingSearchBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final searchBarHeight = getResponsiveValue(context, 48);
    final horizontalPadding = getResponsiveValue(context, 16);

    return Positioned(
      top: getResponsiveValue(context, 16),
      left: horizontalPadding,
      right: horizontalPadding,
      child: ScaleTransition(
        scale: _searchAnim,
        child: Container(
          height: searchBarHeight,
          width: screenWidth - (horizontalPadding * 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getResponsiveValue(context, 24)),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getResponsiveValue(context, 16)),
          child: Row(
            children: [
              Icon(Icons.search,
                  color: Colors.grey, size: getResponsiveValue(context, 24)),
              SizedBox(width: getResponsiveValue(context, 8)),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(fontSize: getResponsiveFontSize(context, 16)),
                  decoration: InputDecoration(
                    hintText: "Search providers...",
                    hintStyle:
                        TextStyle(fontSize: getResponsiveFontSize(context, 16)),
                    border: InputBorder.none,
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear,
                                size: getResponsiveValue(context, 20)),
                            onPressed: () {
                              _searchController.clear();
                              filterProfiles('');
                            },
                          )
                        : null,
                  ),
                  onChanged: filterProfiles,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsedSearchIcon() {
    final iconSize = getResponsiveValue(context, 48);

    return Positioned(
      top: getResponsiveValue(context, 16),
      right: getResponsiveValue(context, 16),
      child: GestureDetector(
        onTap: () {
          _searchAnimController.forward();
          setState(() => _isSearchExpanded = true);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: iconSize,
          width: iconSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Icon(Icons.search,
              color: Colors.grey, size: getResponsiveValue(context, 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = getResponsiveValue(context, 16);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello $name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    fontSize: getResponsiveFontSize(context, 20),
                    color: Colors.black87)),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded,color: Colors.blue,),
                        Text('Surampalem',style: TextStyle(fontSize: 12),),
                      ],
                    )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (_)=>MyNotifications()));},
            icon: Icon(Icons.notifications_none,
                size: getResponsiveValue(context, 24)),
          ),
          SizedBox(width: getResponsiveValue(context, 10)),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.35, 0.7, 1.0],
                colors: [
                  const Color(0xFFFFDEE9).withOpacity(0.8),
                  const Color(0xFFB5FFFC).withOpacity(0.8),
                  const Color(0xFFCAA1FF).withOpacity(0.8),
                  Colors.white.withOpacity(0.8),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(
              top: getResponsiveValue(context, 40) +
                  MediaQuery.of(context).padding.top,
              bottom: getResponsiveValue(context, 80),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
  height: getResponsiveValue(context, 200),
  width: screenWidth,
  child: PageView.builder(
    controller: _tipPageController,
    // 1. Use the length of your images list for the item count
    itemCount: images.length,
    itemBuilder: (context, index) {
      // Get the specific image data for the current page
      final singleImage = images[index];

      return Container(
        width: screenWidth,
        margin:
            EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(getResponsiveValue(context, 16)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
          // 2. Use a DecorationImage to display the image as the container's background
          // This works perfectly with borderRadius
          image: DecorationImage(
            image: AssetImage(singleImage.inmnm),
            fit: BoxFit.cover, // Ensures the image fills the container
          ),
        ),
      );
    },
  ),
),
                SizedBox(height: getResponsiveValue(context, 32)),
                if (!_isCategoryCollapsed) ...[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nearby Services",
                          style: TextStyle(
                            fontSize: getResponsiveFontSize(context, 20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CategoryProfileApp(
                                  profiles: profilesData,
                                  onToggleSave: widget.onToggleSave,
                                  onConfirmBooking: widget.onConfirmBooking,
                                  initialCategory: 'all',
                                ),
                              ),
                            );
                          },
                          child: const Text('See more..'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getResponsiveValue(context, 12)),
                  SizedBox(
                    height: getResponsiveValue(context, 100),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                          horizontal: getResponsiveValue(context, 12)),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CategoryProfileApp(
                                  profiles: profilesData,
                                  onToggleSave: widget.onToggleSave,
                                  onConfirmBooking: widget.onConfirmBooking,
                                  initialCategory: category.name.toLowerCase(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: getResponsiveValue(context, 12)),
                            padding: EdgeInsets.symmetric(
                              horizontal: getResponsiveValue(context, 16),
                              vertical: getResponsiveValue(context, 10),
                            ),
                            constraints: BoxConstraints(
                              minWidth: getResponsiveValue(context, 80),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  getResponsiveValue(context, 16)),
                              border: Border.all(color: Colors.blue.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade100,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  category.icon,
                                  size: getResponsiveValue(context, 28),
                                  color: Colors.blue.shade700,
                                ),
                                SizedBox(
                                    height: getResponsiveValue(context, 6)),
                                Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize:
                                        getResponsiveFontSize(context, 13),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getResponsiveValue(context, 12)),
                ],
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Top Providers",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: getResponsiveValue(context, 12)),
                      Column(
                        children:
                            List.generate(filteredProfiles.length, (index) {
                          final profile = filteredProfiles[index];
                          return Card(
                            margin: EdgeInsets.only(
                                bottom: getResponsiveValue(context, 12)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  getResponsiveValue(context, 12)),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  center: Alignment.topLeft,
                                  radius: 2.0,
                                  colors: [
                                    Colors.white,
                                    Colors.blue.shade50,
                                  ],
                                ),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(
                                    getResponsiveValue(context, 16)),
                                title: Text(
                                  profile.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        getResponsiveFontSize(context, 16),
                                    color: Colors.deepPurple.shade900,
                                  ),
                                ),
                                subtitle: Text(
                                  profile.title,
                                  style: TextStyle(
                                    fontSize:
                                        getResponsiveFontSize(context, 14),
                                    color: Colors.deepPurple.shade700,
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.8),
                                  radius: getResponsiveValue(context, 24),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.deepPurple.shade400,
                                    size: getResponsiveValue(context, 24),
                                  ),
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade100,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.amber.shade700,
                                          size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        profile.rating,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProfileDetailScreen(
                                        profile: profile,
                                        onBooked: () =>
                                            widget.onConfirmBooking(profile.id), onBookingConfirmed: (bookingTime) {  },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isSearchExpanded) _buildFloatingSearchBar(),
          if (!_isSearchExpanded) _buildCollapsedSearchIcon(),
        ],
      ),
    );
  }
}

class CategoryModel {
  final String name;
  final IconData icon;

  CategoryModel({required this.name, required this.icon});
}

class Imgs{
  final String inmnm;
  Imgs({required this.inmnm});
}