import 'package:flutter/material.dart';

class ConsumerScreen extends StatelessWidget {
  const ConsumerScreen({Key? key}) : super(key: key);

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
        body: TabBarView(
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
        // Add more storage tips
      ],
    );
  }

  Widget _buildRecipes() {
    return ListView(
      children: [
        _buildRecipeCard('Vegetable Stir Fry', 'A quick and healthy meal'),
        _buildRecipeCard('Fruit Smoothie', 'Perfect for breakfast'),
        // Add more recipes
      ],
    );
  }

  Widget _buildRecipeCard(String title, String description) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget _buildSustainabilityTips() {
    return ListView(
      children: const [
        ListTile(
          title: Text('Reduce Food Waste'),
          subtitle: Text('Plan your meals and use leftovers creatively'),
        ),
        ListTile(
          title: Text('Compost'),
          subtitle: Text('Turn food scraps into nutrient-rich soil'),
        ),
        // Add more sustainability tips
      ],
    );
  }
}
