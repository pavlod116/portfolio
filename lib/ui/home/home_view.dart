import 'package:flutter/material.dart';
import 'package:portfolio/ui/home/home_view_model.dart';
import 'package:portfolio/ui/home/widgets/card_widget.dart';
import 'package:portfolio/ui/home/widgets/pull_button_widget.dart';
import 'package:portfolio/ui/home/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _backgroundAnimationController;
  late AnimationController _foregroundAnimationController;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _foregroundAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 120),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundAnimation = Tween<double>(begin: 1, end: 0).animate(_backgroundAnimationController);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _backgroundAnimation.addListener(() {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent * _backgroundAnimation.value,
          );
        }
      });
    });


    // Анимация для переднего списка
    _foregroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _foregroundAnimation = CurvedAnimation(
      parent: _foregroundAnimationController,
      curve: Curves.easeInOut,
    );

    _foregroundAnimationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _backgroundAnimationController.dispose();
    _foregroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          final cardsList = homeViewModel.getCard();

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 160),
                child: SizedBox(
                  height: 260,
                  child: AnimatedBuilder(
                    animation: _backgroundAnimation,
                    builder: (context, child) {
                      return ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: cardsList.length,
                        itemBuilder: (context, index) {
                          final card = cardsList[index];
                          double animationValue = _foregroundAnimation.value - 0.1;
                          double delay = (index + 1) * 0.2;
                          if (animationValue < delay) {
                            animationValue = 0;
                          } else {
                            animationValue = (animationValue - delay) / (1 - delay);
                            animationValue = animationValue.clamp(0.0, 0.3);
                          }

                          return Transform.translate(
                            offset: Offset(100 * (1 - _backgroundAnimation.value - 0.4), 1),
                            child: Opacity(
                              opacity: animationValue,
                              child: CardWidgets(
                                card: card,
                                width: 200,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: SizedBox(
                      height: 360,
                      child: AnimatedBuilder(
                        animation: _foregroundAnimation,
                        builder: (context, child) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            itemCount: cardsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final card = cardsList[index];
                              double animationValue = _foregroundAnimation.value;
                              double delay = (index + 1) * 0.2;
                              if (animationValue < delay) {
                                animationValue = 0;
                              } else {
                                animationValue = (animationValue - delay) / (1 - delay);
                                animationValue = animationValue.clamp(0.0, 1.0);
                              }

                              return Transform.translate(
                                offset: Offset(100 * (1 - animationValue), 0),
                                child: Opacity(
                                  opacity: animationValue,
                                  child: CardWidgets(
                                    card: card,
                                    width: 240,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: PullButtonWidget(
                      onHorizontalDragUpdate: context.read<HomeViewModel>().handleDragUpdate,
                      onHorizontalDragEnd: (d) => context.read<HomeViewModel>().handleDragEnd(d, context),
                      dragPosition: context.read<HomeViewModel>().dragPosition,
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
