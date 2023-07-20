import 'dart:io';

class Topic {
  final String id;
  final String name;
  final String subject;
  int understandingLevel;
  final Topic? dependeeTopic;

  Topic({
    required this.id,
    required this.name,
    required this.subject,
    this.understandingLevel = 7,
    this.dependeeTopic,
  });
}

void main() {
  print('------------\nStarting\n------------');

  final subject = 'Maths';

  final topic0 = Topic(id: "0", name: "Topic0", subject: subject);

  final topic12 = Topic(
    id: "12",
    name: 'Topic12',
    subject: subject,
    understandingLevel: 4,
    dependeeTopic: topic0,
  );

  final topic11 = Topic(
    id: "11",
    name: 'Topic11',
    subject: subject,
    understandingLevel: 5,
    dependeeTopic: topic12,
  );
  final topic13 = Topic(
    id: "13",
    name: 'Topic13',
    subject: subject,
    understandingLevel: 2,
    dependeeTopic:
        topic12, //THOSE WHO DONT HAVE DEPENDEE TOPIC ARE ASSIGNED TOPIC 0 BY DEFAULT
  );

  final topic = Topic(
    id: "1",
    name: 'Topic1',
    subject: subject,
    understandingLevel: 4,
    dependeeTopic: topic12,
  );
  final topic2 = Topic(
    id: "2",
    name: 'Topic2',
    subject: subject,
    understandingLevel: 5,
    dependeeTopic: topic12,
  );
  final topic3 = Topic(
    id: "3",
    name: 'Topic3',
    subject: subject,
    understandingLevel: 7,
    dependeeTopic: topic12,
  );

  final topic21 = Topic(
    id: "21",
    name: 'Topic21',
    subject: subject,
    understandingLevel: 3,
    dependeeTopic: topic12,
  );

  final topic20 = Topic(
    id: "20",
    name: 'Topic20',
    subject: subject,
    understandingLevel: 6,
    dependeeTopic: topic12,
  );

  List<Topic> topics = [
    topic3,
    topic2,
    topic,
    topic11,
    topic12,
    topic13,
    topic20,
    topic21
  ];

  RecommenderAlgorithm recommenderAlgorithm =
      RecommenderAlgorithm(topics: topics);

  recommenderAlgorithm.getRecommendedTopics(false);
}

class RecommenderAlgorithm {
  final List<Topic> topics;

  RecommenderAlgorithm({required this.topics});

  void getRecommendedTopics(bool stopStudying) {
    List<Topic> recommendedTopics = topics;

    final List<List<dynamic>> all_topics = [];

    for (Topic topic in recommendedTopics) {
      Topic? dependeeTopic = topic.dependeeTopic;
      List<dynamic> row = [];
      row.add(topic);
      if (dependeeTopic != null) {
        row.add(dependeeTopic);
      }
      all_topics.add(row);
    }

    //SUM GOING INTO ROW
    for (List<dynamic> row in all_topics) {
      int sum = 0;
      for (Topic topic in row) {
        // stdout.write('${topic.name}:${topic.understandingLevel} > ');
        sum += topic.understandingLevel;
      }
      // print('Sum: $sum\n--');
      // level2Sum.add(sum);
      row.add(sum);
    }

    //SORTIN
    List<Topic> recommendations = bubbleSortLevel2(all_topics);
    for (Topic t in recommendations) {
      print('${t.name}');
    }

    //SORTED
    for (List<dynamic> rows in all_topics) {
      for (dynamic topic in rows) {
        if (topic is int) {
          stdout.write('Sum: $topic');
        } else {
          stdout.write('${topic.name}:${topic.understandingLevel} > ');
        }
      }
      print('\n---');
    }
  }

  List<Topic> bubbleSortLevel2(List<List<dynamic>> all_topics) {
    int n = all_topics.length;
    bool swapped;

    for (int i = 0; i < n - 1; i++) {
      swapped = false;

      for (int j = 0; j < n - i - 1; j++) {
        int comparison = compareLevel2(
          all_topics[j],
          all_topics[j + 1],
        );
        if (comparison > 0) {
          List<dynamic> temp = all_topics[j];
          all_topics[j] = all_topics[j + 1];
          all_topics[j + 1] = temp;
          swapped = true;
        }
      }
      if (!swapped) {
        break;
      }
    }
    return bubbleSortLevel1(all_topics);
  }

  int compareLevel2(List<dynamic> rowFirst, List<dynamic> rowSecond) {
    int sumOfRowFirst = rowFirst[rowFirst.length - 1];
    int sumOfRowSecond = rowSecond[rowSecond.length - 1];
    int comparison = sumOfRowFirst.compareTo(sumOfRowSecond);
    return comparison;
  }

  List<Topic> bubbleSortLevel1(List<List<dynamic>> all_topics) {
    int n = all_topics.length;

    while (true) {
      bool somethingChanged = false;
      for (int row = 0; row < n - 1; row++) {
        int noOfTopics = all_topics[row].length;
        if (all_topics[row][noOfTopics - 1] ==
            all_topics[row + 1][noOfTopics - 1]) {
          int comparison = compareLevel1(
            all_topics[row],
            all_topics[row + 1],
          );
          if (comparison > 0) {
            List<dynamic> temp = all_topics[row];
            all_topics[row] = all_topics[row + 1];
            all_topics[row + 1] = temp;
            somethingChanged = true;
          }
        }
      }
      if (somethingChanged == false) {
        break;
      }
    }

    List<Topic> recommendedTopics = [];
    for (List<dynamic> row in all_topics) {
      int n = row.length;
      for (int i = n - 2; i > -1; i--) {
        recommendedTopics.add(row[i]);
      }
    }
    return recommendedTopics;
  }

  int compareLevel1(List<dynamic> rowFirst, List<dynamic> rowSecond) {
    //[-2] is sum of second last element which is Topic
    int understandingOfFirstLevel1TopicOfRowFirst =
        rowFirst[rowFirst.length - 2].understandingLevel;
    int understandingOfFirstLevel1TopicOfRowSecond =
        rowSecond[rowSecond.length - 2].understandingLevel;
    int comparison = understandingOfFirstLevel1TopicOfRowFirst
        .compareTo(understandingOfFirstLevel1TopicOfRowSecond);
    return comparison;
  }

  void updateUnderstandingLevel(
      {required Topic topic, required int newUnderstandingLevel}) {
    topic.understandingLevel = newUnderstandingLevel;
  }
}
