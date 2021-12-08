<?php
declare(strict_types=1);

// @see https://adventofcode.com/2021/day/4

$number_of_rows = 5;
$number_of_columns = 5;
$number_of_cells = $number_of_rows * $number_of_columns;

$input_file = array_key_exists(1, $argv) ? $argv[1] : "input";
$input_filename = $input_file === "test_input" ? "test_input" : "input";
$chosen_input = file_get_contents("4.".$input_filename);

function test_column(array $bitmap, int $column=0): bool
{
  global $number_of_columns;

  $sum = 0;
  for ($i=0; $i < $number_of_columns; $i++) {
    $sum += $bitmap[($number_of_columns * $i) + $column];
  }
  return $sum === 5;
}

function test_row(array $bitmap, int $row=0): bool
{
  global $number_of_columns;

  $row_slice = array_slice($bitmap, ($number_of_columns * $row), $number_of_columns);
  return array_sum($row_slice) === 5;
}

function test_bitmap(array $bitmap): bool
{
  global $number_of_columns;
  $winning_columns = [];
  for ($i=0; $i < $number_of_columns; $i++) {
    if (test_column($bitmap, $i)) {
      array_push($winning_columns, $i);
    }
  }

  global $number_of_rows;
  $winning_rows = [];
  for ($i=0; $i < $number_of_rows; $i++) {
    if (test_row($bitmap, $i)) {
      array_push($winning_rows, $i);
    }
  }

  return count($winning_columns) > 0 || count($winning_rows) > 0;
}

function index_of_value(array $array, int|string $needle): ?int
{
  $matches = array_keys($array, $needle);
  if (count($matches) > 0) {
    return $matches[0];
  } else {
    return NULL;
  }
}

function test_boards(array $boards, array $calls): array
{
  global $number_of_cells;

  $empty_bitmap = array_fill(0, $number_of_cells, 0);
  $bitmaps = array_fill(0, count($boards), $empty_bitmap);

  $winning_board_index = $squid_board_index = NULL;
  $winning_call_index = $squid_call_index = NULL;

  $completed_board_indexes = [];

  for ($call_index=0; $call_index < count($calls); $call_index++) {
    for ($board_index=0; $board_index < count($boards); $board_index++) {
      if (in_array($board_index, $completed_board_indexes)) {
        continue;
      }

      $board = $boards[$board_index];

      $match_index = index_of_value($board, $calls[$call_index]);
      if (!is_null($match_index)) {
        $bitmaps[$board_index][$match_index] = 1;
      }

      if (test_bitmap($bitmaps[$board_index])) {
        if (is_null($winning_board_index)) {
          $winning_board_index = $board_index;
          $winning_call_index = $call_index;
        }

        array_push($completed_board_indexes, $board_index);

        if (count($completed_board_indexes) === count($boards)) {
          $squid_board_index = $board_index;
          $squid_call_index = $call_index;
          break;
        }
      }
    }

    if (!is_null($squid_board_index)) {
      break;
    }
  }

  if (!is_null($winning_board_index)) {
    return [
      "winning_board" => $boards[$winning_board_index],
      "winning_bitmap" => $bitmaps[$winning_board_index],
      "winning_call" => $calls[$winning_call_index],
      "squid_board" => $boards[$squid_board_index],
      "squid_bitmap" => $bitmaps[$squid_board_index],
      "squid_call" => $calls[$squid_call_index],
    ];
  }

  return [];
}

function score_board(array $board, array $bitmap, int $call): int
{
  global $number_of_cells;

  $sum = 0;
  for ($i=0; $i < $number_of_cells; $i++) {
    if ($bitmap[$i] === 0) {
      $sum += $board[$i];
    }
  }

  return $sum * $call;
}

$rows = explode("\n", $chosen_input);
$calls = array_map("intval", explode(",", array_shift($rows)));

$boards = [];
$parsed_board_count = 0;
$parsed_row_count = 0;
foreach ($rows as $row => $data) {
  if ($data !== "") {
    $cells = preg_split("/\s+/", trim($data));
    if (!array_key_exists($parsed_board_count, $boards)) {
      $boards[$parsed_board_count] = [];
    }

    $boards[$parsed_board_count] = array_merge($boards[$parsed_board_count], array_map("intval", $cells));
    if ($parsed_row_count == 4) {
      $parsed_row_count = 0;
      $parsed_board_count++;
    } else {
      $parsed_row_count++;
    }
  }
}

$result = test_boards($boards, $calls);
$winning_score = NULL;
$squid_score = NULL;
if (count($result) > 0) {
  $winning_score = score_board($result["winning_board"], $result["winning_bitmap"], $result["winning_call"]);
  $squid_score = score_board($result["squid_board"], $result["squid_bitmap"], $result["squid_call"]);
}

echo("Your winning score: ".$winning_score."\n");
echo("The squid's score: ".$squid_score)

?>
