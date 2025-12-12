import 'dart:io';
//import 'dart:math';

//1. Score 클래스 (부모)
// 단순히 점수만 저장하고 출력

class Score {
  int score;
  Score(this.score);
  
  void showinfo() {
    print('점수 : $score');
  }
  }

//2. StudentScore 자식 
//학생 이름과 과목까지 포함하여 더 구체적인 정보를 출력
//showinfo() override


class StudentScore extends Score
{
  String name;
  //int score
  StudentScore(this.name, super.score);
  
  @override
  void showinfo() {
    print('이름: $name, 점수: $score');
  }
}


//학생 리스트 저장
List<StudentScore> students = [];

//파일에서 학생 데이터 읽기

void readdata() {
  File file = File("students.txt"); //이파일에서 데이터 읽을거야!
  List<String> lines = file.readAsLinesSync();
// 파일의 모든줄을 한 줄씩 리스트로 읽어옴
//탐, 80
//제인, 90
//밥, 77
//List<String> lines = ["tom, 80", "Jane, 90", "Bob, 77"]

   for (String line in lines) {
     if (line.trim().isEmpty) continue; 
     //continue 의미는 프로그램 실행 계속이 아니라 이번 줄 스킵하고 넘어가라는 뜻!

     List<String> cut = line.split(',');
     String name = cut[0].trim();
     int score = int.parse(cut[1].trim());

     students.add(StudentScore(name, score));
   }

  }

// 사용자로부터 이름 입력받고 학생점수찾기

StudentScore waituser() {
  while (true) {
    print("어떤 학생의 통계를 확인하시겠습니까?");
    String? input = stdin.readLineSync();
    if (input == null) continue; //사용가가 넣은 이름이 null이면 스킵
    String name = input.trim(); 

    for (StudentScore s in students) {
      if (s.name == name) {
        s.showinfo(); //결과
        return s;  //main()으로 돌려줌
      }
    } print("잘못된 학생 이름입니다. 다시입력하세요.");
  }
}

//프로그램 종료후 파일을 저장

void save(StudentScore student) {
  File file = File("result.txt");

  String text = "이름: ${student.name}, 점수: ${student.score}";
  file.writeAsStringSync(text);

  print("저장이 완료되었습니다.");
}

//main()
void main() {
  readdata();                   // 파일에서 데이터 불러오기
  StudentScore a = waituser();  // 사용자한테 입력받기까지 기다렸다가 학생찾기
  save(a);                      // 결과 파일 저장 

}







