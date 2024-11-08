import 'dart:io';
import 'dart:math';
import 'package:dart_game/dart_game.dart' as dart_game;

class Game {
  late Character character;
  late List<Monster> monsters;
  late int monsterCount; // 물리친 몬스터 수

  Game() {
    character = loadCharacterStats();
    monsters = loadMonsterStats(character);
    monsterCount = 0;
  }

  void startGame() {
    print('게임을 시작합니다.');

    //도전기능 : 30%의 확률로 캐릭터에게 보너스 체력 10 증가
    // 0 ~ 9 까지 10가지의 숫자
    if (Random().nextInt(10) < 3) {
      character.health += 10;
      print('보너스 체력을 얻었습니다!  현재체력 : ${character.health}');
    }
    character.showStatus();
    print('\n');

    while (character.health > 0) {
      battle();

      //캐릭터가 패배했는지 확인
      if (character.health <= 0) {
        print('\n');
        print('${character.name}이 패배했습니다. 게임을 종료합니다.');
        saveResult(character, '패배');
        break;
      }

      // 물리친 몬스터 수가 3개 이상이면 승리
      if (monsterCount >= 3 || monsters.isEmpty) {
        print('축하합니다! 모든 몬스터를 물리쳤습니다!');
        saveResult(character, '승리');
        break;
      }

      print('\n');
      print('다음 몬스터와 대결하시겠습니까? (y/n): ');
      String? input = stdin.readLineSync()?.toLowerCase().trim();

      while (input != 'y' && input != 'n') {
        stdout.write('잘못된 입력입니다. y 또는 n을 입력해주세요: ');
        input = stdin.readLineSync()?.toLowerCase().trim();
      }

      if (input == 'y') {
        continue;
      } else if (input == 'n') {
        if (character.health > 0) {
          saveResult(character, '승리');
        } else {
          saveResult(character, '패배');
        }
        break;
      }
    }
  }

  void battle() {
    int monsterIndex = getRandomMonster();
    bool isMonsterDefeated = false;
    bool isCharacterTurn = true; // 캐릭터의 턴을 나타내는 플래그

    print('새로운 몬스터가 나타났습니다!');
    monsters[monsterIndex].showStatus();

    while (!isMonsterDefeated && character.health > 0) {
      //캐릭터의 턴
      if (isCharacterTurn) {
        print('\n');
        print('${character.name}의 턴');

        stdout.write('행동을 선택하세요 (1: 공격 2: 방어): ');
        String? input = stdin.readLineSync()?.trim();

        while (input != '1' && input != '2') {
          stdout.write('잘못된 입력입니다. 다시 입력해주세요. (1: 공격, 2: 방어): ');
          input = stdin.readLineSync()?.trim();
        }

        // 캐릭터의 공격
        if (input == '1') {
          character.attackMonster(monsters[monsterIndex]);
        }
        // 캐릭터의 방어
        else if (input == '2') {
          character.defend(monsters[monsterIndex]);
        }
      }
      //몬스터의 공격 턴
      else {
        print('\n');
        print('${monsters[monsterIndex].name}의 턴');
        monsters[monsterIndex].attackCharacter(character);
        character.showStatus();
        monsters[monsterIndex].showStatus();
      }

      isCharacterTurn = !isCharacterTurn;

      // 몬스터가 패배했는지 확인
      if (monsters[monsterIndex].health <= 0) {
        monsterCount++;
        isMonsterDefeated = true;
        print('${monsters[monsterIndex].name}을(를) 물리쳤습니다!');
        monsters.removeAt(monsterIndex);
      }
    }
  }

  //몬스터 리스트에 대한 랜덤 인덱스 반환
  int getRandomMonster() {
    return Random().nextInt(monsters.length);
  }
}

class Character {
  String name;
  int health;
  int attack;
  int defense;

  Character(this.name, this.health, this.attack, this.defense);

  //공격 : 대결 상대인 몬스터의 체력을 감소
  void attackMonster(Monster monster) {
    monster.health -= attack;
    print('$name이(가) ${monster.name}에게 $attack의 데미지를 입혔습니다.');
  }

  //방어 : 대결 상대인 몬스터가 입힌 damage만큼 캐릭터의 체력을 상승
  void defend(Monster monster) {
    int damage = monster.attack - defense;
    if (damage < 0) damage = 0;
    health += damage;
    print('$name이(가) 방어 태세를 취하여 $damage만큼 체력이 상승하였습니다.');
  }

  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}

class Monster {
  String name;
  int health;
  int attack; //랜덤으로 지정할 공격력 범위의 최대값
  int defense;

  Monster(this.name, this.health, this.attack, this.defense);

  //공격 : 대결 상대인 캐릭터의 체력을 감소
  void attackCharacter(Character character) {
    int damage = attack - character.defense;
    if (damage < 0) damage = 0;
    character.health -= damage;
    print('$name이(가) ${character.name}에게 $damage만큼 데미지를 입혔습니다.');
  }

  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack');
  }
}

String getCharacterName() {
  while (true) {
    stdout.write('캐릭터 이름을 입력하세요: ');
    String? name = stdin.readLineSync()?.trim();
    if (name == null ||
        name.isEmpty ||
        !RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(name)) {
      print('유효하지 않은 이름입니다. 특수문자나 숫자를 제외한 한글, 영문 대소문자만 사용하세요.');
    } else {
      return name;
    }
  }
}

void saveResult(Character character, String result) {
  print('\n');
  stdout.write('결과를 저장하시겠습니까? (y/n): ');
  String? input = stdin.readLineSync()?.toLowerCase().trim();

  while (input != 'y' && input != 'n') {
    stdout.write('잘못된 입력입니다. y 또는 n을 입력해주세요: ');
    input = stdin.readLineSync()?.toLowerCase().trim();
  }

  if (input == 'y') {
    try {
      final file = File('assets/result.txt');
      file.writeAsStringSync(
          '캐릭터 이름: ${character.name}, 남은 체력: ${character.health}, 게임 결과: $result\n',
          mode: FileMode.append);
      print('결과가 result.txt 파일에 저장되었습니다.');
    } catch (e) {
      print('결과를 저장하는 데 실패했습니다: $e');
      exit(1);
    }
  } else if (input == 'n') {
    print('결과 저장 없이 종료합니다. ');
  }
}

Character loadCharacterStats() {
  try {
    final file = File('assets/characters.txt');
    if (!file.existsSync())
      throw FileSystemException('characters.txt 파일이 존재하지 않습니다.');

    final contents = file.readAsStringSync();
    final stats = contents.split(',');
    if (stats.length != 3) throw FormatException('Invalid character data');

    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);

    String name = getCharacterName();
    return Character(name, health, attack, defense);
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

List<Monster> loadMonsterStats(Character character) {
  try {
    final file = File('assets/monsters.txt');
    if (!file.existsSync())
      throw FileSystemException('monsters.txt 파일이 존재하지 않습니다.');

    final contents = file.readAsStringSync();
    final lines = contents.split('\n');
    List<Monster> monsters = [];

    for (var line in lines) {
      final stats = line.split(',');
      if (stats.length != 3) throw FormatException('Invalid Monster data');

      String name = stats[0];
      int health = int.parse(stats[1]);
      int maxAttack = int.parse(stats[2]);
      int attack = max(Random().nextInt(maxAttack) + 1,
          character.defense); // 캐릭터의 방어력과 랜덤값 중 최대값을 설정. 랜덤값은 1~maxAttack까지의 난수

      Monster monster = Monster(name, health, attack, 0);
      //print('monster : ${monster.name}, attack : ${monster.attack}');
      monsters.add(monster);
    }

    return monsters;
  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1); // 프로그램 종료 및 운영체제에 프로그램이 특정 오류로 인해 비정상적으로 종료되었음을 알린다
  }
}

void main(List<String> arguments) {
  Game game = Game();
  game.startGame();
}
