import 'dart:io';

// list of all valid moves.
const List<String> validMoves = ['rock', 'paper', 'scissors'];

/// gets a player's name.
/// if the input is null or empty, a default player name is used.
String getPlayerName(int playerNumber) {
  stdout.write('Enter Player $playerNumber name: ');

  String? input = stdin.readLineSync();

  String name = (input ?? '').trim();
  String defaultName = 'Player $playerNumber';

  if (name.isEmpty) {
    print('(Walay name gibutang. Using "$defaultName" as default name.)');
    return defaultName;
  }

  return name;
}

/// checks kung ang gi-entered move is valid.
/// returns the move in lowercase kung valid.
/// returns null kung ang move is invalid.
String? validateMove(String? input) {
  String move = (input ?? '').trim().toLowerCase();

  if (validMoves.contains(move)) {
    return move;
  }

  return null;
}

/// repeatedly asks a player for a move until a valid/spelling move is entered.
String getMove(String playerName) {
  while (true) {
    stdout.write(
      '$playerName, Pili ug move (rock/paper/scissors): ',
    );

    String? input = stdin.readLineSync();
    String? move = validateMove(input);

    if (move != null) {
      return move;
    }

    print('Di mao na move. Please type rock, paper, or scissors.');
  }
}

/// decides which player wins the round.
/// returns "player1" if Player 1 wins.
/// returns "player2" if Player 2 wins.
/// returns null if the round is a draw.
String? decideWinner(
  String playerOneMove,
  String playerTwoMove,
) {
  if (playerOneMove == playerTwoMove) {
    return null;
  }

  switch (playerOneMove) {
    case 'rock':
      if (playerTwoMove == 'scissors') {
        return 'player1';
      } else {
        return 'player2';
      }

    case 'paper':
      if (playerTwoMove == 'rock') {
        return 'player1';
      } else {
        return 'player2';
      }

    case 'scissors':
      if (playerTwoMove == 'paper') {
        return 'player1';
      } else {
        return 'player2';
      }

    default:
      return null;
  }
}

/// Starts the Rock, Paper, Scissors game.
void main() {
  print('===== 🪨 ROCK, 📄 PAPER, ✂️ SCISSORS =====');

  String playerOneName = getPlayerName(1);
  String playerTwoName = getPlayerName(2);

  int playerOneScore = 0;
  int playerTwoScore = 0;
  int roundNumber = 1;

  String playAgain = 'y';

  do {
    print('');
    print('--- Round $roundNumber ---');

    // P 1 enters a move.
    String playerOneMove = getMove(playerOneName);

    // print about 10 blank lines to hide P 1's move.
    for (int line = 0; line < 10; line++) {
      print('');
    }

    // P 2 enters a move.
    String playerTwoMove = getMove(playerTwoName);

    print('');
    print(
      '$playerOneName chose $playerOneMove. '
      '$playerTwoName chose $playerTwoMove.',
    );

    // nullable result from decideWinner().
    String? winningPlayer = decideWinner(
      playerOneMove,
      playerTwoMove,
    );

    // round result is also nullable.
    String? winner;

    if (winningPlayer == 'player1') {
      playerOneScore++;
      winner = '$playerOneName wins the round!';
    } else if (winningPlayer == 'player2') {
      playerTwoScore++;
      winner = '$playerTwoName wins the round!';
    } else {
      winner = null;
    }

    // use ?? to safely display a draw when winner is null.
    print('Result: ${winner ?? "It's a draw!"}');

    print(
      'Score -> $playerOneName: $playerOneScore | '
      '$playerTwoName: $playerTwoScore',
    );

    print('');

    // ask until the player enters y or n. y = yes, n = no
    while (true) {
      stdout.write('Duwa paba? (y/n): ');

      String? playAgainInput = stdin.readLineSync();

      playAgain = (playAgainInput ?? 'n')
          .trim()
          .toLowerCase();

      if (playAgain == 'y' || playAgain == 'n') {
        break;
      }

      print('Di mao. Please type y or n.');
    }

    roundNumber++;
  } while (playAgain == 'y');

  // Final score.
  print('');
  print('===== FINAL SCORE =====');

  print(
    '$playerOneName: $playerOneScore | '
    '$playerTwoName: $playerTwoScore',
  );

  String overallWinner;

  if (playerOneScore > playerTwoScore) {
    overallWinner = playerOneName;
  } else if (playerTwoScore > playerOneScore) {
    overallWinner = playerTwoName;
  } else {
    overallWinner = "Draw man bai!";
  }

  print('Winner: $overallWinner');
}