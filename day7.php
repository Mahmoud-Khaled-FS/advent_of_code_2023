<?php
if (count($argv) < 2) {
  echo "ERROR: Invalid file path";
  exit(1);
}

$file_path = $argv[1];

$content = file_get_contents($file_path);

$lines = explode("\n", $content);


$cards_sorted = [
  1 => [],
  2 => [],
  3 => [],
  4 => [],
  5 => [],
  6 => [],
  7 => [],
];

foreach ($lines as $line) {
  $game = explode(" ", $line);
  $cards = $game[0];
  $type =  get_type($cards, $part = 2);
  array_push($cards_sorted[$type], $game);
}
handle_game($cards_sorted,  $part = 2);

function get_type($cards, $part = 1)
{
  $cards_freq = [];
  for ($i = 0; $i < 5; $i++) {
    $card = $cards[$i];
    if (array_key_exists($card, $cards_freq)) {
      $cards_freq[$card] += 1;
    } else {
      $cards_freq[$card] = 1;
    }
  }
  $two_pair = 0;
  if ($part == 2 and array_key_exists("J", $cards_freq)) {
    $most_freq = "";
    foreach ($cards_freq as $key => $value) {
      if ($key != "J") {
        if ($most_freq == "") {
          $most_freq = $key;
        } else {
          if ($value < $cards_freq[$most_freq]) {
            $most_freq = $key;
          }
        }
      }
    }
    $cards_freq[$most_freq] += $cards_freq["J"];
    unset($cards_freq["J"]);
  }
  foreach ($cards_freq as $key => $value) {
    if ($value == 5) {
      return 7;
    } else if ($value == 4) {
      return 6;
    } else if ($value == 3 and count($cards_freq) == 2) {
      return 5;
    } else if ($value == 3 and count($cards_freq) == 3) {
      return 4;
    } else if ($value == 2) {
      $two_pair++;
    }
  }
  if ($two_pair == 2) {
    return 3;
  } else if ($two_pair == 1) {
    return 2;
  }
  return 1;
}

function handle_game($cards_lvl, $part = 1)
{
  $result = 0;
  $rank = 1;
  foreach ($cards_lvl as $value => $cards) {
    $cards_in_lvl = $cards;
    $part1_rank = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"];
    $part2_rank = ["J", "2", "3", "4", "5", "6", "7", "8", "9", "T", "Q", "K", "A"];
    $list = $part == 1 ? $part1_rank : $part2_rank;
    usort($cards_in_lvl,  function ($card1, $card2) use ($list) {
      for ($i = 0; $i < 5; $i++) {
        $v1 = array_search($card1[0][$i], $list);
        $v2 = array_search($card2[0][$i], $list);
        if ($v1 == $v2) continue;
        if ($v1 > $v2) {
          return 1;
        } else {
          return -1;
        }
      }
    });
    foreach ($cards_in_lvl as $card) {
      $result += intval($card[1], 10) * $rank;
      $rank++;
    }
  }
  echo $result;
}
