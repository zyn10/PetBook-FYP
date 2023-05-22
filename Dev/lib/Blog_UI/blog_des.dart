import 'package:flutter/material.dart';

String baconText =
    'Bacon ipsum dolor amet kielbasa frankfurter shankle bresaola ribeye doner. Drumstick biltong frankfurter, tri-tip bresaola buffalo jerky pig strip steak tongue. T-bone burgdoggen turkey, tail venison tenderloin drumstick frankfurter bacon meatball pastrami prosciutto. Porchetta jowl shoulder spare ribs, boudin kielbasa landjaeger beef ribs filet mignon ham sausage tri-tip swine rump meatloaf. Pastrami ribeye chislic short ribs, filet mignon kielbasa pork belly capicola shankle venison sirloin.Chicken doner filet mignon jowl, ham andouille ground round tri-tip chuck ham hock spare ribs landjaeger sirloin porchetta tail. Burgdoggen fatback chislic t-bone tri-tip cow sausage biltong frankfurter cupim pork chop strip steak. Ground round tongue hamburger leberkas ball tip prosciutto. Strip steak corned beef ham cupim kevin. Meatloaf pig prosciutto cupim.Ground round beef ribs boudin, buffalo pork pork chop sirloin bresaola jowl ham. Fatback beef chicken pork belly shankle pork, pork chop meatball andouille pastrami. Strip steak meatball frankfurter tongue, pork belly landjaeger boudin. Chicken frankfurter bacon brisket beef ribs beef jowl, ground round salami landjaeger drumstick alcatra andouille pancetta pastrami.';

class BlogDescription extends StatelessWidget {
  const BlogDescription({
    super.key,
    required this.title,
    required this.imagePath,
  });

  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Image.asset(imagePath),
            const SizedBox(height: 20.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20.0),
            Text(
              baconText,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ]),
        ),
      ),
    );
  }
}
