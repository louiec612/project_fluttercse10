import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_fluttercse10/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../getset.dart';
import '../../model/cardModel.dart';
import '../../provider/cardProvider.dart';
import '../Home View/homeView.dart';

class quizView extends StatefulWidget {
  const quizView({super.key});

  @override
  State<quizView> createState() => _quizViewState();
}

class _quizViewState extends State<quizView> {
  int _current = 0;
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  String cardName = "Flashcard Name";
  @override
  Widget build(BuildContext context) {
    return Consumer<CardClass>(
      builder: (BuildContext context, provider, Widget? child) => Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Row(children: [
                SizedBox(width: getWid.wSize * 2 / 10),
                IconButton(
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(width: 10),
                Text(
                  cardName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ]),
              const SizedBox(height: 90),
              CarouselSlider.builder(
                  itemCount: provider.allCards.length,
                  itemBuilder: (context,index,realIndex){
                    final card = provider.allCards[index];
                    return VisibilityCard(card: card);
                  },
                  options: CarouselOptions(
                    height: getHgt.hSize / 1.54,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index; // Update the current index
                      });
                    },
                  ),
              ),
              Column(
                children: [
                  Text('${_current + 1}/${provider.allCards.length}'),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: LinearProgressIndicator(
                      value: (_current + 1) / provider.allCards.length,
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VisibilityCard extends StatefulWidget {
  final Cards card;


  const VisibilityCard({Key? key, required this.card})
      : super(key: key);

  @override
  State<VisibilityCard> createState() => _VisibilityCardState();
}

class _VisibilityCardState extends State<VisibilityCard> {
  bool visible = false;
  bool _isSmall = false;
  void _toggleSize() {
    setState(() {
      _isSmall = !_isSmall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 500), // Animation duration
                curve: Curves.easeInOut,
                height:
                    _isSmall ? getHgt.hSize / 3.4 : (getHgt.hSize / 3.4) + 50,
                decoration: BoxDecoration(
                  color: color.col,
                ),
                child: Center(
                    child: Text(
                  widget.card.question,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )),
              ),
            ),
            const SizedBox(height: 30),
            if (visible)
              _answerContainer(widget: widget)
                  .animate()
                  .fadeIn(duration: 700.ms, curve: Curves.easeIn)
                  .slideY(
                      delay: 100.ms, duration: 500.ms, curve: Curves.easeInOut),
          ],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          width: (getWid.wSize - 100),
          curve: Curves.easeInOut,
          bottom: _isSmall ? (getHgt.hSize / 3.6) + 50 : (getHgt.hSize / 3.6),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 55,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  _toggleSize();
                  setState(() {
                    visible = !visible; // Toggle visibility
                  });
                },
                icon: _isSmall
                    ? const Icon(
                        Icons.keyboard_arrow_up,
                        size: 35,
                      )
                    : const Icon(
                        Icons.keyboard_arrow_down,
                        size: 35,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _answerContainer extends StatelessWidget {
  const _answerContainer({
    super.key,
    required this.widget,
  });

  final VisibilityCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          color: color.col, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(widget.card.answer,
            style: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
