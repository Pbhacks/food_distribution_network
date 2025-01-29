import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ConsumerScreen extends StatefulWidget {
  const ConsumerScreen({Key? key}) : super(key: key);

  @override
  _ConsumerScreenState createState() => _ConsumerScreenState();
}

class _ConsumerScreenState extends State<ConsumerScreen> {
  late List<Map<String, String>> _recipes;
  late List<Map<String, String>> _sustainabilityTips;
  bool _isLoading = true;

  final Map<String, String> _recipeVideoIds = {
    'Vegetable Stir Fry': 'deoawaSi5Xs',
    'Fruit Smoothie': '4wX3iSmD5cI',
    'Quinoa Salad': 'QwE4UZ2vukE',
    'Lentil Soup': 'oi-dcSkR-FQ',
    'Baked Salmon': '2uYoqclu6so',
    'Vegetarian Chili': 'oy1u49dLgaE',
    'Greek Yogurt Parfait': '6rglgwP-r50',
    'Spinach and Mushroom Omelette': 'FLwB5r68iO8',
    'Roasted Vegetable Medley': 'GTqZg-JIhA4',
    'Whole Grain Pasta Primavera': 'j1hAAcPay1w',
  };

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _recipes = _generateRecipes();
      _sustainabilityTips = _generateSustainabilityTips();
      _isLoading = false;
    });
  }

  List<Map<String, String>> _generateRecipes() {
    return _recipeVideoIds.keys
        .map((name) => {'name': name, 'videoId': _recipeVideoIds[name]!})
        .toList();
  }

  List<Map<String, String>> _generateSustainabilityTips() {
    return [
      {
        'title': 'Reduce Food Waste',
        'description':
            'Plan meals, use leftovers creatively, and compost scraps'
      },
      {
        'title': 'Choose Seasonal Produce',
        'description':
            'Buy fruits and vegetables that are in season for better taste and lower environmental impact'
      },
      {
        'title': 'Eat More Plant-Based Meals',
        'description':
            'Incorporate more vegetables, fruits, and whole grains into your diet'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Consumer Engagement'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.food_bank), text: 'Storage Guide'),
              Tab(icon: Icon(Icons.restaurant), text: 'Recipes'),
              Tab(icon: Icon(Icons.eco), text: 'Sustainability'),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildStorageGuide(),
                  _buildRecipesGrid(),
                  _buildSustainabilityTips(),
                ],
              ),
      ),
    );
  }

  Widget _buildStorageGuide() {
    return ListView(
      children: const [
        ListTile(
            title: Text('Fruits'),
            subtitle: Text('Store most fruits in the refrigerator')),
        ListTile(
            title: Text('Vegetables'),
            subtitle: Text('Keep potatoes and onions in a cool, dark place')),
        ListTile(
            title: Text('Bread'),
            subtitle:
                Text('Store in a bread box or paper bag at room temperature')),
        ListTile(
            title: Text('Dairy'),
            subtitle: Text('Keep in the coldest part of the refrigerator')),
        ListTile(
            title: Text('Meat'),
            subtitle: Text('Store on the bottom shelf of the refrigerator')),
      ],
    );
  }

  Widget _buildRecipesGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          String title = _recipes[index]['name']!;
          String videoId = _recipes[index]['videoId']!;
          String thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeVideoScreen(
                    title: title,
                    videoId: videoId,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      thumbnailUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSustainabilityTips() {
    return ListView.builder(
      itemCount: _sustainabilityTips.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(Icons.eco, color: Colors.green[500]),
            title: Text(_sustainabilityTips[index]['title']!),
            subtitle: Text(_sustainabilityTips[index]['description']!),
          ),
        );
      },
    );
  }
}

class RecipeVideoScreen extends StatelessWidget {
  final String title;
  final String videoId;

  const RecipeVideoScreen(
      {Key? key, required this.title, required this.videoId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
