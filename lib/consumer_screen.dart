import 'package:flutter/material.dart';
import 'dart:math';

class ConsumerScreen extends StatefulWidget {
  const ConsumerScreen({Key? key}) : super(key: key);

  @override
  _ConsumerScreenState createState() => _ConsumerScreenState();
}

class _ConsumerScreenState extends State<ConsumerScreen> {
  late List<Map<String, String>> _recipes;
  late List<Map<String, String>> _sustainabilityTips;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _recipes = _generateRecipes();
      _sustainabilityTips = _generateSustainabilityTips();
      _isLoading = false;
    });
  }

  List<Map<String, String>> _generateRecipes() {
    return [
      {
        'name': 'Vegetable Stir Fry',
        'description': 'A quick and healthy meal with mixed vegetables'
      },
      {
        'name': 'Fruit Smoothie',
        'description': 'Blend your favorite fruits for a refreshing drink'
      },
      {
        'name': 'Quinoa Salad',
        'description': 'Protein-packed salad with vegetables and lemon dressing'
      },
      {
        'name': 'Lentil Soup',
        'description': 'Hearty soup with lentils, vegetables, and spices'
      },
      {
        'name': 'Baked Salmon',
        'description': 'Oven-baked salmon with herbs and lemon'
      },
      {
        'name': 'Vegetarian Chili',
        'description':
            'Spicy chili with beans, vegetables, and plant-based protein'
      },
      {
        'name': 'Greek Yogurt Parfait',
        'description': 'Layered yogurt with fruits, nuts, and honey'
      },
      {
        'name': 'Spinach and Mushroom Omelette',
        'description': 'Protein-rich breakfast with vegetables'
      },
      {
        'name': 'Roasted Vegetable Medley',
        'description': 'Assorted vegetables roasted with olive oil and herbs'
      },
      {
        'name': 'Whole Grain Pasta Primavera',
        'description': 'Pasta with fresh spring vegetables and light sauce'
      },
    ];
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
      {
        'title': 'Use Reusable Containers',
        'description':
            'Bring your own containers for takeout and leftovers to reduce single-use plastics'
      },
      {
        'title': 'Support Local Farmers',
        'description':
            'Buy from local farmers\' markets to reduce transportation emissions'
      },
      {
        'title': 'Grow Your Own Herbs',
        'description':
            'Start a small herb garden to have fresh herbs on hand and reduce packaging'
      },
      {
        'title': 'Properly Store Food',
        'description':
            'Learn how to store different foods to extend their shelf life and reduce waste'
      },
      {
        'title': 'Use Every Part',
        'description':
            'Find creative ways to use vegetable scraps, like making stock from peels and stems'
      },
      {
        'title': 'Reduce Meat Consumption',
        'description':
            'Try "Meatless Mondays" or reducing portion sizes of meat in meals'
      },
      {
        'title': 'Choose Sustainable Seafood',
        'description': 'Use guides to select seafood from sustainable sources'
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
                  _buildRecipes(),
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
          subtitle: Text('Store most fruits in the refrigerator'),
        ),
        ListTile(
          title: Text('Vegetables'),
          subtitle: Text('Keep potatoes and onions in a cool, dark place'),
        ),
        ListTile(
          title: Text('Bread'),
          subtitle:
              Text('Store in a bread box or paper bag at room temperature'),
        ),
        ListTile(
          title: Text('Dairy'),
          subtitle: Text('Keep in the coldest part of the refrigerator'),
        ),
        ListTile(
          title: Text('Meat'),
          subtitle: Text('Store on the bottom shelf of the refrigerator'),
        ),
      ],
    );
  }

  Widget _buildRecipes() {
    return ListView.builder(
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        return _buildRecipeCard(
            _recipes[index]['name']!, _recipes[index]['description']!);
      },
    );
  }

  Widget _buildRecipeCard(String title, String description) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            // TODO: Implement recipe detail view
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Opening recipe for $title')),
            );
          },
        ),
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
            title: Text(_sustainabilityTips[index]['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(_sustainabilityTips[index]['description']!),
          ),
        );
      },
    );
  }
}
