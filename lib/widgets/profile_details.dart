import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
//import 'package:quickfixproject/models/data.dart';
import 'package:quickfix_project/models/data.dart';

// --- UI Constants for a cohesive theme ---
const kAccentColor = Color(0xFFF97316); // Orange accent
const kBackgroundColor = Color(0xFFFFF7F5); // A very light cream/orange background
const kTextColor = Color(0xFF1A202C);
const kGreyColor = Color(0xFF6A7280);

class ProfileDetailScreen extends StatefulWidget {
  final Profile profile;
  final VoidCallback onBooked; // Callback for when booking is confirmed

  const ProfileDetailScreen(
      {super.key, required this.profile, required this.onBooked, required Null Function(dynamic bookingTime) onBookingConfirmed});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  // Method to show the booking confirmation dialog
  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Booking Confirmed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Your appointment with ${widget.profile.name} has been scheduled.'),
                const SizedBox(height: 8),
                Text('You can view it in your bookings.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Method to show the bottom sheet for date and time picking
  void _showBookingSheet() async {
    final bool? bookingConfirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return BookingConfirmationSheet(profileName: widget.profile.name);
      },
    );

    // If the sheet returns true, it means booking was confirmed
    if (bookingConfirmed == true) {
      widget.onBooked(); // This calls _toggleSave in main.dart
      await _showConfirmationDialog(); // Show the confirmation popup
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Go back from the profile detail screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),
      backgroundColor: kBackgroundColor,
      // Pass the new _showBookingSheet method to the button
      bottomNavigationBar: _buildBookNowButton(_showBookingSheet),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildInfoAndStats(),
          _buildStickyTabBar(),
          _buildTabBarContent(),
        ],
      ),
    );
  }
  
  // Unchanged methods are collapsed for brevity, except the button builder
  
  Widget _buildBookNowButton(VoidCallback onBookPressed) {
    return BottomAppBar(
      elevation: 10,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ElevatedButton(
          onPressed: onBookPressed, // Use the passed function
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 8,
            shadowColor: const Color.fromARGB(255, 107, 208, 255).withOpacity(0.4),
            backgroundColor: Colors.transparent,
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [  Color.fromARGB(255, 255, 66, 126).withOpacity(0.6),
              Color.fromARGB(255, 75, 255, 249).withOpacity(0.6),
               Color.fromARGB(255, 146, 63, 255).withOpacity(0.6),
              Colors.white.withOpacity(0.6),],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text('Book Now',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
  return SliverAppBar(
    expandedHeight: 280.0,
    pinned: true,
    floating: false,
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: kTextColor),
    actions: [
      IconButton(
        icon: const Icon(Icons.favorite_outline_rounded),
        onPressed: () {},
      ),
    ],
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        widget.profile.name,
        style: const TextStyle(
          color: kTextColor,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
      background: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            widget.profile.personImage,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.5, 1.0],
                colors: [
                  Colors.transparent,
                  kBackgroundColor.withOpacity(1),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildInfoAndStats() {
    return SliverToBoxAdapter(
      child: Container(
        transform: Matrix4.translationValues(0.0, -25.0, 0.0),
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.profile.title,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kTextColor)),
              const SizedBox(height: 8),
              Text(widget.profile.category,
                  style: const TextStyle(
                      fontSize: 16,
                      color: kGreyColor,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn(Icons.construction_rounded,
                      '${widget.profile.yearsExperience} Years', 'Experience'),
                  _buildStatColumn(Icons.checklist_rtl_rounded,
                      '${widget.profile.projectsCompleted}+', 'Projects'),
                  _buildStatColumn(
                      Icons.star_half_rounded, widget.profile.rating, 'Rating'),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  SliverPersistentHeader _buildStickyTabBar() {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        TabBar(
          controller: _tabController,
          labelColor: const Color.fromARGB(255, 133, 191, 249),
          unselectedLabelColor: kGreyColor,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromARGB(255, 133, 191, 249).withOpacity(0.1),
          ),
          indicatorPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          tabs: const [
            Tab(text: 'About'),
            Tab(text: 'Gallery'),
            Tab(text: 'Reviews'),
          ],
        ),
      ),
      pinned: true,
    );
  }

  Widget _buildTabBarContent() {
    return SliverFillRemaining(
      child: Container(
        color: Colors.white, // Ensures the rest of the content area is white
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildAboutTab(),
            _buildGalleryTab(),
            _buildReviewsTab(),
          ],
        ),
      ),
    );
  }

Widget _buildAboutTab() {
   return SingleChildScrollView(
     padding: const EdgeInsets.all(24),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         const Text('About Service',
             style: TextStyle(
                 fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
         const SizedBox(height: 8),
         Text(widget.profile.bio,
             style:
                 const TextStyle(fontSize: 15, color: kGreyColor, height: 1.5)),
         const SizedBox(height: 24),
         const Text('Pricing',
             style: TextStyle(
                 fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
         const SizedBox(height: 12),
         Container(
           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
           decoration: BoxDecoration(
             color: kBackgroundColor,
             borderRadius: BorderRadius.circular(12),
           ),
           child: Row(
             children: [
               const Icon(Icons.currency_rupee_rounded,
                   color: Color.fromARGB(255, 133, 191, 249), size: 20),
               const SizedBox(width: 8),
               const Text(
                 'Starting from ₹499', // Example price
                 style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.bold,
                   color: kTextColor,
                 ),
               ),
               const Spacer(),
               Text(
                 '(Varies by work)',
                 style: TextStyle(
                   fontSize: 13,
                   color: kGreyColor,
                   fontStyle: FontStyle.italic,
                 ),
               )
             ],
           ),
         ),
         const SizedBox(height: 24),
         const Divider(),
         const SizedBox(height: 24),
         const Text('Services Offered',
             style: TextStyle(
                 fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
         const SizedBox(height: 12),
         Wrap(
           spacing: 10.0,
           runSpacing: 10.0,
           children: widget.profile.services
               .map((service) => Chip(
                     label: Text(service),
                     backgroundColor: const Color.fromARGB(255, 133, 191, 249).withOpacity(0.1),
                     labelStyle: const TextStyle(
                         color:Color.fromARGB(255, 133, 191, 249), fontWeight: FontWeight.w600),
                     padding: const EdgeInsets.symmetric(
                         horizontal: 12, vertical: 8),
                   ))
               .toList(),
         ),
       ],
     ),
   );
 }


  Widget _buildGalleryTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: widget.profile.galleryImages.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(widget.profile.galleryImages[index],
              fit: BoxFit.cover),
        );
      },
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: widget.profile.reviews.length,
      itemBuilder: (context, index) {
        final review = widget.profile.reviews[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        backgroundImage: AssetImage(review.userImageUrl)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(review.userName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: kTextColor)),
                    ),
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(review.rating.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: kTextColor)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(review.comment, style: const TextStyle(color: kGreyColor)),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildStatColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 133, 191, 249), size: 28),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: kGreyColor)),
      ],
    );
  }
  // END OF UNCHANGED METHODS
}

// Helper class to make the TabBar sticky
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // Changed from kBackgroundColor for a clean separation
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// NEW WIDGET FOR THE BOTTOM SHEET
class BookingConfirmationSheet extends StatefulWidget {
  final String profileName;
  const BookingConfirmationSheet({super.key, required this.profileName});

  @override
  State<BookingConfirmationSheet> createState() =>
      _BookingConfirmationSheetState();
}

class _BookingConfirmationSheetState extends State<BookingConfirmationSheet> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20,
          20 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book ${widget.profileName}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select your desired date and time for the service.',
            style: TextStyle(fontSize: 15, color: kGreyColor),
          ),
          const SizedBox(height: 24),
          _buildPickerRow(
            icon: Icons.calendar_today_outlined,
            label: 'Date',
            value: _selectedDate != null
                ? DateFormat.yMMMd().format(_selectedDate!)
                : 'Select Date',
            onTap: _pickDate,
          ),
          const SizedBox(height: 16),
          _buildPickerRow(
            icon: Icons.access_time_outlined,
            label: 'Time',
            value: _selectedTime != null
                ? _selectedTime!.format(context)
                : 'Select Time',
            onTap: _pickTime,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 220, 245, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Confirm Booking',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                // Return true to signal confirmation
                Navigator.pop(context, true);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPickerRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))
        ),
        child: Row(
          children: [
            Icon(icon, color: kGreyColor),
            const SizedBox(width: 16),
            Text(label, style: const TextStyle(fontSize: 16, color: kTextColor)),
            const Spacer(),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kAccentColor)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 14, color: kGreyColor),
          ],
        ),
      ),
    );
  }
}