// A new class to model a single review
class Review {
  final String userName;
  final String userImageUrl;
  final double rating;
  final String comment;

  Review({
    required this.userName,
    required this.userImageUrl,
    required this.rating,
    required this.comment,
  });
}

class Category {
  final String id;
  final String name;
  final String imagePath;

  Category({required this.id, required this.name, required this.imagePath});
}

class Profile {
  final String id;
  final String name;
  final String personImage;
  final String category;
  final String title;
  final String bio;
  final String email;
  final String phone;
  final String rating;
  bool isSaved;
  bool isBooked;

  // New fields for more details
  final int yearsExperience;
  final int projectsCompleted;
  final List<String> services;
  final List<String> galleryImages;
  final List<Review> reviews;

  Profile({
    required this.id,
    required this.name,
    required this.category,
    required this.title,
    required this.bio,
    this.email = 'N/A',
    this.phone = 'N/A',
    this.rating = 'N/A',
    this.isSaved = false,
    required this.yearsExperience,
    required this.projectsCompleted,
    required this.services,
    required this.galleryImages,
    required this.reviews,
    required this.personImage,
    this.isBooked = false,
  });
}

final List<Category> categoriesData = [
  Category(id: 'all', name: 'All Services', imagePath: 'assets/all.png'),
  Category(id: 'plumbing', name: 'Plumbing', imagePath: 'assets/plumb.jpg'),
  Category(id: 'electrical', name: 'Electrical', imagePath: 'assets/bulbs.jpg'),
  Category(id: 'cleaning', name: 'Cleaning', imagePath: 'assets/cleaning.jpg'),
  Category(id: 'painter', name: 'Painter', imagePath: 'assets/gardening.jpg'),
  Category(id: 'carpentry', name: 'Carpentry', imagePath: 'assets/carpentry.jpg'),
  Category(id: 'gardening', name: 'Gardening', imagePath: 'assets/gardening.jpg'),
  Category(id: 'tutor', name: 'Tution', imagePath: 'assets/tutor.jpg'),
  Category(id: 'driver', name: 'Driver', imagePath: 'assets/driver.jpg'),
  Category(id: 'chef', name: 'Chef', imagePath: 'assets/chef.jpg'),
  Category(id: 'mechanic', name: 'Mechanic', imagePath: 'assets/mechanic.jpg'),
  Category(id: 'photographer', name: 'Photographer', imagePath: 'assets/photographer.jpg'),
  Category(id: 'pest control', name: 'Pest Control', imagePath: 'assets/pestcontrol.jpg'),
  Category(id: 'laundry', name: 'Laundry', imagePath: 'assets/laundry.jpg'),
  Category(id: 'movers & packers', name: 'Movers & Packers', imagePath: 'assets/movers.jpg'),
  Category(id: 'internet', name: 'WIFI Setup', imagePath: 'assets/internet.jpg'),
  Category(id: 'beautician', name: 'Beautician', imagePath: 'assets/beauty.jpg'),
  Category(id: 'coolie', name: 'Coolie', imagePath: 'assets/coolie.jpg'),
];


final List<Profile> profilesData = [
  Profile(
    id: 's1',
    name: 'Mike Plumber',
    category: 'plumbing',
    title: 'Master Plumber',
    bio: 'Expert in leak repairs, pipe installations, and drain cleaning with a focus on customer satisfaction and durable solutions.',
    email: 'mike.p@example.com',
    phone: '555-2001',
    rating: '4.8',
    yearsExperience: 10,
    projectsCompleted: 250,
    services: ['Leak Repair', 'Drain Cleaning', 'Pipe Installation', 'Water Heaters'],
    galleryImages: ['assets/plumbing.jpg', 'assets/plumbing.jpg', 'assets/plumbing.jpg'],
    reviews: [
      Review(userName: 'Alice Johnson', userImageUrl: 'assets/plumbing.jpg', rating: 5, comment: 'Mike was fast, professional, and fixed our leak in no time!'),
      Review(userName: 'Bob Williams', userImageUrl: 'assets/plumbing.jpg', rating: 4.5, comment: 'Great service. A bit pricey but worth it for the quality.'),
    ], personImage: 'assets/person1.jpg',
  ),
  Profile(
    id: 's2',
    name: 'Sarah Spark',
    category: 'electrical',
    title: 'Certified Electrician',
    bio: 'Specializing in residential and commercial wiring, fixture installation, and electrical troubleshooting.',
    email: 'sarah.s@example.com',
    phone: '555-2002',
    rating: '4.9',
    yearsExperience: 8,
    projectsCompleted: 180,
    services: ['Wiring', 'Fixture Installation', 'Troubleshooting', 'Panel Upgrades'],
    galleryImages: ['assets/plumbing.jpg', 'assets/plumbing.jpg', 'assets/plumbing.jpg'],
    reviews: [
      Review(userName: 'Charlie Brown', userImageUrl: 'assets/plumbing.jpg', rating: 5, comment: 'Sarah rewired our entire kitchen. Flawless work!'),
    ], personImage: 'assets/person2.jpg',
  ),
  Profile(
    id: 's3',
    name: 'Clean Sweep Co.',
    category: 'cleaning',
    title: 'Deep Cleaning Specialist',
    bio: 'Providing thorough residential and commercial cleaning services using eco-friendly products for a spotless finish.',
    email: 'cleansweep@example.com',
    phone: '555-2003',
    rating: '4.7',
    yearsExperience: 5,
    projectsCompleted: 400,
    services: ['Residential Cleaning', 'Commercial Cleaning', 'Window Washing', 'Carpet Cleaning'],
    galleryImages: ['assets/plumbing.jpg', 'assets/plumbing.jpg', 'assets/plumbing.jpg', 'assets/plumbing.jpg'],
    reviews: [
      Review(userName: 'Diana Prince', userImageUrl: 'assets/plumbing.jpg', rating: 4.5, comment: 'My apartment has never been cleaner. They were very thorough.'),
      Review(userName: 'Eve Adams', userImageUrl: 'assets/plumbing.jpg', rating: 5, comment: 'Excellent service for our office space. Highly recommend.'),
    ], personImage: 'assets/person3.jpg',
  ),
  Profile(
    id: 's4',
    name: 'Woody Craftsman',
    category: 'carpentry',
    title: 'Skilled Carpenter',
    bio: 'Custom furniture, cabinet repairs, and general woodworking with a keen eye for detail and craftsmanship.',
    email: 'woody.c@example.com',
    phone: '555-2004',
    rating: '4.8',
    yearsExperience: 15,
    projectsCompleted: 120,
    services: ['Custom Furniture', 'Deck Building', 'Cabinet Repair', 'Trim Work'],
    galleryImages: ['assets/plumbing.jpg', 'assets/plumbing.jpg'],
    reviews: [
      Review(userName: 'Frank Castle', userImageUrl: 'assets/plumbing.jpg', rating: 5, comment: 'Woody built us a beautiful custom bookshelf. True artistry.'),
    ], personImage: 'assets/person4.jpg',
  ),
  Profile(
    id: 's5',
    name: 'Flora Green',
    category: 'gardening',
    title: 'Landscape Gardener',
    bio: 'Passionate about creating beautiful and sustainable garden spaces. Services include design, planting, and regular maintenance.',
    email: 'flora.g@example.com',
    phone: '555-2005',
    rating: '4.9',
    yearsExperience: 7,
    projectsCompleted: 95,
    services: ['Landscape Design', 'Planting & Mulching', 'Lawn Care', 'Weed Control'],
    galleryImages: ['assets/plumbing.jpg', 'assets/plumbing.jpg', 'assets/plumbing.jpg'],
    reviews: [
      Review(userName: 'Grace Lee', userImageUrl: 'assets/plumbing.jpg', rating: 5, comment: 'Flora transformed our backyard into an oasis! She is wonderful to work with.'),
      Review(userName: 'Henry Allen', userImageUrl: 'assets/plumbing.jpg', rating: 5, comment: 'Our garden is thriving thanks to Flora\'s regular maintenance.'),
    ], personImage: '- assets/person5.jpg',
  ),
];