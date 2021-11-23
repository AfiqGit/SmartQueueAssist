class PatientNumber{
final int totalPatient;
final String currentTime;

  PatientNumber(this.currentTime, this.totalPatient);

  PatientNumber.fromMap(Map<String, dynamic> map)
  : assert(map['totalPatient'] != null),
    assert(map['currentTime'] != null),
    totalPatient= map['totalPatient'],
    currentTime= map['currentTime'];

}