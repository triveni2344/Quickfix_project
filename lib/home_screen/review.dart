import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: ReviewsScreen()));
}

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F5),
      appBar: AppBar(
        title: const Text('Customer Feedback Dashboard',style:TextStyle(color:Colors.white)),
       // backgroundColor: Color.fromARGB(255, 12, 26, 62),
       backgroundColor: Color(0xFF006D77),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.35, 0.7, 1.0],
            colors: [
              Color(0xFFFFDEE9), // light pink
              Color(0xFFB5FFFC), // light blue
              Color(0xFFCAA1FF), // light purple
              Colors.white.withOpacity(0.5), // touch of white
            ],
          ),
        ), 
      child:SingleChildScrollView(
        child: Column(
          children: [
            RatingSummary(
              averageRating: 4.6,
              totalReviews: 123,
              ratingsDistribution: {
                5: 78,
                4: 25,
                3: 10,
                2: 6,
                1: 4,
              },
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent Customer Feedback",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...sampleReviews.map((r) => ReviewCard(review: r)),
            const SizedBox(height: 30),
          ],
        ),
      ),
      ),
    );
  }
}

// Model
class CustomerReview {
  final String username;
 // final String avatarUrl;
 final String avatarAsset;
  final double rating;
  final String date;
  final String reviewText;

  CustomerReview({
    required this.username,
    // required this.avatarUrl,
    required this.avatarAsset,
    required this.rating,
    required this.date,
    required this.reviewText,
  });
}

// Sample Data
final List<CustomerReview> sampleReviews = [
  CustomerReview(
    username: 'Alice M.',
    avatarAsset: 'assets/men1.jpg',
    rating: 5.0,
    date: 'July 24, 2025',
    reviewText: 'Absolutely love it! The product quality is excellent and delivery was super fast!',
  ),
  CustomerReview(
    username: 'John D.',
    avatarAsset: 'assets/men4.jpg',
    rating: 4.0,
    date: 'July 20, 2025',
    reviewText: 'Good value for the price. Customer support was responsive.',
  ),
  CustomerReview(
    username: 'Rachel S.',
    avatarAsset: 'assets/men3.jpg',
    rating: 3.0,
    date: 'July 15, 2025',
    reviewText: 'Product was okay. Packaging could be improved.',
  ),
];

// ReviewCard with Like + Respond Features
class ReviewCard extends StatefulWidget {
  final CustomerReview review;

  const ReviewCard({super.key, required this.review});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  String? providerResponse;
  bool isLiked = false;

  void _showRespondDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reply to Customer'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Write your response here...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  providerResponse = controller.text.trim();
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Your response has been recorded.')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isLiked
            ? 'You liked this review.'
            : 'You removed your like from this review.'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final review = widget.review;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (avatar, name, date)
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(review.avatarAsset), radius: 22),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(review.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Rating stars
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < review.rating.round() ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                );
              }),
            ),
            const SizedBox(height: 10),

            // Review text
            Text(
              review.reviewText,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 10),

            // Like and Respond buttons
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    color: isLiked ? Colors.deepPurple : Colors.grey[600],
                    size: 20,
                  ),
                  onPressed: _toggleLike,
                ),
                Text(
                  isLiked ? "Liked" : "Like",
                  style: TextStyle(
                    color: isLiked ? Colors.deepPurple : Colors.grey[600],
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _showRespondDialog,
                  child: const Text("Respond", style: TextStyle(color: Colors.deepPurple)),
                ),
              ],
            ),

            // Provider response
            if (providerResponse != null && providerResponse!.isNotEmpty) ...[
              const Divider(),
              const Text(
                "Your Response:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(providerResponse!),
            ]
          ],
        ),
      ),
    );
  }
}

// Rating Summary Widget
class RatingSummary extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingsDistribution;

  const RatingSummary({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingsDistribution,
  });

  @override
  Widget build(BuildContext context) {
    final maxCount = ratingsDistribution.values.fold<int>(0, (a, b) => a > b ? a : b);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.amber, Colors.deepOrange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Icon(
                    index < averageRating.round() ? Icons.star : Icons.star_border,
                    color: Colors.white,
                    size: 28,
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            Text(
              '$totalReviews verified reviews',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Column(
              children: List.generate(5, (i) {
                int star = 5 - i;
                int count = ratingsDistribution[star] ?? 0;
                double factor = maxCount > 0 ? count / maxCount : 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: Text(
                          '$star',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: LinearProgressIndicator(
                            value: factor,
                            minHeight: 12,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$count',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}