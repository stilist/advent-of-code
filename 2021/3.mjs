'use strict';

// @see https://adventofcode.com/2021/day/3

import {
  argv,
} from 'process'
import testInput from './3-test_input.mjs'
import input from './3-input.mjs'

const inputFile = argv[2] || 'input'
const selectedInput = inputFile === 'test_input' ? testInput : input

/**
 * @param {number} input
 * @param {number} bitLength
 * @returns {number}
 */
const invertBits = (input, bitLength) => {
  let output = 0
  for (let index = 0; index < bitLength; index++) {
    output |= (0b1 ^ (0b1 & input >> index)) << index
  }
  return output
}

const bitLength = selectedInput[0].length
/** @type number[] */
const initialValue = new Array(bitLength).fill(0, 0)
const selectedInputBitArray = selectedInput.map(line => (
  line.split('')
    .map(character => parseInt(character, 2))
))

/** @type number */
const gamma = selectedInputBitArray
  .reduce((memo, bits) => (
    bits.map((digit, index) => memo[index] + (digit === 0 ? -1 : 1))
  ), initialValue)
  .reduce((memo, bit) => (memo << 1) | (bit < 1 ? 0b0 : 0b1), 0)
let epsilon = invertBits(gamma, bitLength)
console.log(`Power consumption: ${gamma} (γ) ⋅ ${epsilon} (ε) = ${gamma * epsilon}`)

/**
 * @typedef PartitionInput
 * @type {object}
 * @property {number} bitLength
 * @property {number[]} input
 * @property {number} mask
*/
/**
 * @param {PartitionInput}
 */
const lifeSupport = ({
  bitLength,
  input,
  mask,
}) => {
  let co2 = input.slice()
  let oxygen = input.slice()

  for (let index = bitLength - 1; index >= 0; index--) {
    const oxygenBit = (mask >> index) & 0b1
    if (oxygen.length > 1) {
      oxygen = oxygen.filter(candidate => oxygenBit === ((candidate >> index) & 0b1))
    }

    const co2Bit = 0b1 ^ oxygenBit
    if (co2.length > 1) {
      co2 = co2.filter(candidate => co2Bit === ((candidate >> index) & 0b1))
    }
  }

  return [
    co2[0],
    oxygen[0]
  ]
}

const lifeSupportInput = selectedInputBitArray
  .map(bitArray => {
    let bitfield = 0
    for (let bit of bitArray) bitfield = (bitfield << 1) | bit
    return bitfield
  })
const [
  oxygen,
  co2,
] = lifeSupport({
  bitLength,
  input: lifeSupportInput,
  mask: gamma,
})
console.log(`Life support rating: ${oxygen} (O generator) ⋅ ${co2} (CO₂ scrubber) = ${oxygen * co2}`)
