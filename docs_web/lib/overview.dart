import 'package:desktop/desktop.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Overview',
              style: Theme.of(context).textTheme.hearder,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(style: Theme.of(context).textTheme.body1, text: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce fermentum, elit sed vestibulum consectetur, mauris nisl cursus tellus, ac gravida urna magna a mi. Sed condimentum metus id purus faucibus tempor. Aenean sit amet fringilla elit, in tincidunt nibh. In hac habitasse platea dictumst. Aliquam quis justo iaculis, congue justo sed, pharetra nunc. In arcu felis, pellentesque eget sem id, aliquam molestie eros. In eleifend enim in eros varius, a lacinia nibh volutpat. Quisque fermentum velit nec quam auctor, ac maximus odio laoreet. Donec quis accumsan dui. Cras tempus urna vitae ex interdum, a pharetra magna venenatis. Ut ultrices est nec quam dictum, vitae tristique tellus posuere.

Aliquam erat volutpat. Vivamus metus arcu, cursus eu justo sed, varius lobortis leo. Sed facilisis sodales mi non aliquam. Proin vehicula turpis eget elit aliquam, ullamcorper ultrices nibh sodales. Praesent id fermentum mi. Vivamus mollis feugiat tortor eget vulputate. Nulla malesuada in ipsum luctus auctor. Donec pharetra urna id dapibus elementum. Integer mi nibh, imperdiet eu fringilla id, varius ac sem. Vivamus efficitur ornare tellus in tempor.

Ut tempor eros sed eleifend porttitor.'''),
                TextSpan(text: '''
Nullam vitae ex eu arcu mollis venenatis. Curabitur quis urna eget risus facilisis luctus. In finibus imperdiet viverra. Aliquam consequat, lacus et euismod pulvinar, enim lacus pellentesque magna, sed posuere erat tortor eget elit. Vivamus consectetur condimentum augue commodo feugiat. Donec in lobortis ante, at consequat urna.

Cras luctus mollis enim at lobortis. Donec tincidunt nibh et lectus faucibus ornare. Vivamus elementum, urna vel vulputate viverra, urna nulla eleifend urna, vel tempor risus arcu at magna. Sed eu ante sagittis ante blandit imperdiet. Duis tortor arcu, suscipit mattis velit vitae, ornare hendrerit ex. Proin vestibulum rhoncus dui ac pharetra. Maecenas sit amet magna a lacus mollis aliquam. Nulla augue orci, rutrum sit amet auctor vitae, sodales sit amet mi. Aliquam in iaculis est. Vivamus non scelerisque leo. Cras lacinia nisl eget dui tempor, in hendrerit enim tempor. Curabitur sagittis efficitur tellus, vitae imperdiet felis sollicitudin nec. In vitae purus sagittis, tincidunt purus in, scelerisque mauris. Suspendisse vel massa orci.

Nulla pulvinar dolor mauris, id laoreet dolor placerat a. Proin elit neque, eleifend malesuada semper sed, bibendum in erat. Vestibulum turpis dolor, ultrices aliquam neque et, pharetra tristique purus. Vivamus orci purus, convallis pellentesque diam et, pretium aliquam orci. Fusce interdum ligula a sapien molestie suscipit. Praesent imperdiet leo semper auctor euismod. Morbi vehicula sit amet felis in venenatis. Mauris nec tortor et velit mattis volutpat. Suspendisse potenti. Morbi ultricies turpis ligula, quis vestibulum ex venenatis sed. Pellentesque lorem nisi, bibendum a eros at, venenatis egestas risus. Nunc dignissim dignissim odio, non iaculis lorem volutpat id. Ut aliquam nulla ut libero fermentum rhoncus nec nec mauris. Sed eget velit neque. Donec ac nunc in lorem scelerisque gravida sed in lacus. 

''')
              ],
            ),
          )
        ],
      ),
    );
  }
}
