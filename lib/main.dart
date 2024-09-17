import 'package:flutter/material.dart';
import 'api_service.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API and SQLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostListScreen(),
    );
  }
}

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late Future<List<Post>> posts = Future.value([]); // Initialize with an empty future

  @override
  void initState() {
    super.initState();
    _fetchAndStorePosts();
  }

  Future<void> _fetchAndStorePosts() async {
    ApiService apiService = ApiService();
    DatabaseHelper dbHelper = DatabaseHelper.instance;

    // Fetch posts from API
    List<Post> apiPosts = await apiService.fetchPosts();

    // Store each post in SQLite
    for (var post in apiPosts) {
      await dbHelper.insertPost(post);
    }

    // Fetch posts from local SQLite
    setState(() {
      posts = dbHelper.fetchPosts();
    });
  }

  Color _getColorForUser(int userId) {
    // Define a list of colors for different users
    List<Color> colors = [
      Colors.lightBlueAccent,
      Colors.lightGreenAccent,
      Colors.orangeAccent,
      Colors.amberAccent
    ];
    // Return a color based on userId, using modulo to ensure it wraps around the list
    return colors[userId % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Post post = snapshot.data![index];
              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: _getColorForUser(post.userId),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        post.body,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'User: ${post.userId}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
