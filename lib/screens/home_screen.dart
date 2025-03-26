import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_state.dart';
import 'package:news_app/news_service.dart';
import 'package:news_app/screens/details_screen.dart';
import 'package:news_app/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewsCubit>().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(
        title: Text("News"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is NewsLoaded) {
            return RefreshIndicator(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        context.read<NewsCubit>().searchNews(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        final news = state.news[index];
                        return Container(
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              news["title"],
                              style: TextStyle(fontSize: 22),
                            ),
                            subtitle: Text(news["body"].substring(0, 100)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DetailsScreen(news: news),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              onRefresh: () async {
                context.read<NewsCubit>().fetchNews();
              },
            );
          }

          return Center(child: Text("No news availbale"));
        },
      ),
    );
  }
}
