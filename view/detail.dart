import 'package:flutter/material.dart';
import 'package:game_app/viewmodel/fetchgame.dart';
import 'package:game_app/model/detailgame.dart';
import 'package:readmore/readmore.dart';

class Detail extends StatelessWidget {
  final int gameTerpilih;

  const Detail({super.key, required this.gameTerpilih});

  Future<DetailGame> fetchData() async {
    final jsonData = await fetchDataFromAPI(gameTerpilih);
    return DetailGame.fromJson(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400,
      body: FutureBuilder<DetailGame>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('Data tidak tersedia'),
            );
          }

          final game = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GAMBAR UTAMA
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      child: Image.network(
                        game.thumbnail,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // TOMBOL KEMBALI
                    Positioned(
                      top: 40,
                      left: 15,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // JUDUL GAME
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    game.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // INFORMASI GAME
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Genre: ${game.genre}'),
                      Text('Platform: ${game.platform}'),
                      Text('Publisher: ${game.publisher}'),
                      Text('Developer: ${game.developer}'),
                      Text('Release Date: ${game.release_date}'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // MINIMUM SYSTEM REQUIREMENTS
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Minimum System Requirements',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'OS: ${game.minimum_system_requirements.os}',
                          ),
                          Text(
                            'Processor: ${game.minimum_system_requirements.processor}',
                          ),
                          Text(
                            'Memory: ${game.minimum_system_requirements.memory}',
                          ),
                          Text(
                            'Graphics: ${game.minimum_system_requirements.graphics}',
                          ),
                          Text(
                            'Storage: ${game.minimum_system_requirements.storage}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // SCREENSHOT GAME
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Screenshots',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: game.screenshots.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            game.screenshots[index].image,
                            width: 280,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // DESKRIPSI
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ReadMoreText(
                    game.description,
                    trimLines: 4,
                    colorClickableText: Colors.blue,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Lihat selengkapnya',
                    trimExpandedText: 'Tampilkan lebih sedikit',
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
