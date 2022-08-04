// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/model/message_model.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as getxTransitions;
import 'package:http/http.dart' as http;

class MensagemArquivoMaybe extends StatelessWidget {
  const MensagemArquivoMaybe({
    Key? key,
    required this.myMensagem,
    required this.showNumber,
  }) : super(key: key);

  final MessageModel myMensagem;
  final bool showNumber;

  @override
  Widget build(BuildContext context) {
    // ! Maybe
    if (myMensagem.mediaLink == '') {
      return const SizedBox();
    }
    // list of video file extensions
    var videoExtensions = [
      'mp4',
      'mov',
      'm4v',
      'avi',
      'flv',
      'wmv',
      '3gp',
      'mkv',
      'webm'
    ];

    return MensagemImagem(myMensagem: myMensagem);
  }
}

class MensagemImagem extends StatefulWidget {
  const MensagemImagem({
    Key? key,
    required this.myMensagem,
  }) : super(key: key);

  final MessageModel myMensagem;

  @override
  State<MensagemImagem> createState() => _MensagemImagemState();
}

class _MensagemImagemState extends State<MensagemImagem> {
  bool notImage = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: notImage
              ? null
              : () {
                  Get.to(
                    () => Scaffold(
                      appBar: AppBar(),
                      body: Center(
                        child: Hero(
                          tag: widget.myMensagem.mediaLink,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: widget.myMensagem.mediaLink,
                              placeholder: (context, url) => const Loading(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    transition: getxTransitions.Transition.topLevel,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
          child: Hero(
            tag: widget.myMensagem.mediaLink,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) {
                  Future.delayed(
                    const Duration(milliseconds: 0),
                    () {
                      try {
                        setState(() {
                          notImage = true;
                        });
                      } catch (e) {
                        print('');
                      }
                    },
                  );

                  return MensagemVideo(
                    mensagem: widget.myMensagem,
                  );
                },
                imageUrl: widget.myMensagem.mediaLink,
                placeholder: (context, url) => const Loading(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MensagemVideo extends StatefulWidget {
  const MensagemVideo({
    Key? key,
    required this.mensagem,
  }) : super(key: key);
  final MessageModel mensagem;

  @override
  State<MensagemVideo> createState() => _MensagemVideoState();
}

class _MensagemVideoState extends State<MensagemVideo> {
  late VideoPlayerController _controller;
  bool hover = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.mensagem.mediaLink, videoPlayerOptions: VideoPlayerOptions())
      ..initialize().then(
        (_) {
          setState(() {});
        },
      );
    _controller.setVolume(0.2);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var url = widget.mensagem.mediaLink;
    if (_controller.value.hasError) {
      return TextButton(
        onPressed: () async {
          var dUrl = "data:application/octet-stream;charset=utf-16le;base64,${(base64.encode((await http.get(Uri.parse(url))).bodyBytes.toList())).toString()}";
          // html.AnchorElement(href: dUrl)
          //   ..setAttribute("download", "gambiarra_kkkkkkkk_jesusCristoEuPrecisoRefazerOSistemaDeEnvioDeArquivoTodinho")
          //   ..click();
        },
        child: const Text("Aquivo Desconhecido kkkkkkk"),
      );
    }
    return _controller.value.isInitialized
        ? MouseRegion(
            onEnter: (a) {
              setState(() {
                hover = true;
              });
            },
            onExit: (a) {
              setState(() {
                hover = false;
              });
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 900,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(
                              _controller,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: LayoutBuilder(
                          builder: (e, c) {
                            return GestureDetector(
                              onTapDown: (d) {
                                var proportion = d.localPosition.dx / c.maxWidth;
                                _controller.seekTo(Duration(milliseconds: (_controller.value.duration.inMilliseconds * proportion).toInt()));
                                _controller.play();
                              },
                              child: SizedBox(
                                width: c.maxWidth,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          child: AnimatedOpacity(
                                            duration: const Duration(milliseconds: 200),
                                            curve: Curves.easeInOut,
                                            opacity: hover ? 0.7 : 0,
                                            child: AnimatedContainer(
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.fastLinearToSlowEaseIn,
                                              color: Colors.grey,
                                              height: 20,
                                              width: c.maxWidth,
                                            ),
                                          ),
                                        ),
                                        ClipRRect(
                                          child: AnimatedOpacity(
                                            duration: const Duration(milliseconds: 200),
                                            curve: Curves.easeInOut,
                                            opacity: hover ? 1 : 0,
                                            child: AnimatedContainer(
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.fastLinearToSlowEaseIn,
                                              color: Colors.red,
                                              height: 20,
                                              width: c.maxWidth * (_controller.value.position.inMilliseconds / _controller.value.duration.inMilliseconds),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: IconButton(
                            icon: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              opacity: hover ? 1 : 0,
                              child: Icon(
                                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 50,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              if (_controller.value.duration.inMilliseconds == _controller.value.position.inMilliseconds) {
                                _controller.seekTo(const Duration(seconds: 0));
                                _controller.play();
                                return;
                              }
                              _controller.value.isPlaying ? _controller.pause() : _controller.play();
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
