import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_demo/constants/img_font_color_string.dart';
import 'package:graphql_demo/model/character_model.dart';
import 'package:graphql_demo/provider/api_provider.dart';
import 'package:graphql_demo/screen/details.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pages = 1;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("GraphQl Demo"),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8),
      child: Consumer<CharacterAPIProvider>(
        builder: (context, characterProvider, child) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : characterProvider.characters == null
                  ? Center(child: Text(Constants.noDatafound))
                  : RefreshIndicator(
                      onRefresh: () async {
                        pages = 1;
                        await Provider.of<CharacterAPIProvider>(context,
                                listen: false)
                            .fetchData(pages);
                      },
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: characterProvider.characters?.data
                                  ?.characters?.results?.length ??
                              0,
                          itemBuilder: (context, index) {
                            Result? result = characterProvider
                                .characters?.data?.characters?.results![index];
                            return LazyLoadingList(
                                index: index,
                                loadMore: () async {
                                  debugPrint("More data loading...");
                                  pages++;
                                  await Provider.of<CharacterAPIProvider>(
                                          context,
                                          listen: false)
                                      .fetchData(pages);
                                },
                                hasMore: pages <=
                                    (characterProvider.characters?.data
                                            ?.characters?.info?.pages ??
                                        0),
                                child: _buildCard(result));
                          }),
                    );
        },
      ),
    );
  }

  Widget _buildCard(
    Result? result,
  ) {
    return InkWell(
      onTap: () {
        // Push to detail screen...
        if (result != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailView(
                  result: result,
                ),
              ));
        }
      },
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(result?.image ?? "")),
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.black38,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                  child: Center(
                    child: Text(
                      result?.name ?? "-",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> fetchData() async {
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      await Provider.of<CharacterAPIProvider>(context, listen: false)
          .fetchData(pages);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
