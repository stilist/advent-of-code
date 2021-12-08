'use strict'

// @see https://adventofcode.com/2021/day/2

import {
  argv,
} from 'process'
import testInput from './2-test_input.mjs'
import input from './2-input.mjs'

const inputFile = argv[2] || 'input'
const selectedInput = inputFile === 'test_input' ? testInput : input

const position = {
  aim: 0,
  x: 0,
  naiveY: 0,
  realY: 0,
}

const pattern = /(?<direction>down|forward|up) (?<amount>\d+)/
for (let line of selectedInput) {
  const {
    amount: raw_amount,
    direction,
  } = line.match(pattern).groups
  const amount = parseInt(raw_amount, 10)
  switch (direction) {
    case 'down':
      position.aim += amount
      position.naiveY += amount
      break
      case 'up':
      position.aim -= amount
      position.naiveY -= amount
      break
      case 'forward':
      position.x += amount
      position.realY += position.aim * amount
      break
  }
}

console.log(`Part 1: ${position.x * position.naiveY}`)
console.log(`Part 2: ${position.x * position.realY}`)
