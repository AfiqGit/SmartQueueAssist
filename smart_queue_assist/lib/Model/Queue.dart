class Queue{
  final String userId;
  final String queueNumber;
  final int timeRegistered;
  final int timeEnter;
  final String name;

  Queue({this.userId, this.queueNumber, this.timeEnter, this.timeRegistered, this.name});
  
}

class Counter{
  final String counter;

  Counter({this.counter});
}