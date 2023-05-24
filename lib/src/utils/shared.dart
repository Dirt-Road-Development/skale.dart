/// @license
/// Dirt Road Development SKALE.dart
///
/// This program is free software: you can redistribute it and/or modify
/// it under the terms of the GNU Lesser General Public License as published by
/// the Free Software Foundation, either version 3 of the License, or
/// (at your option) any later version.
///
/// This program is distributed in the hope that it will be useful,
/// but WITHOUT ANY WARRANTY; without even the implied warranty of
/// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
/// GNU Lesser General Public License for more details.
///
/// You should have received a copy of the GNU Lesser General Public License
/// along with this program.  If not, see <https://www.gnu.org/licenses/>.
///
/// @file shared.dart
/// @author Sawyer Cutler
/// @copyright Dirt Road Development 2022-Present

import 'dart:math';
import 'dart:typed_data';

/// Credit for this function goes to simolus3
/// Original implementation from web3dart
/// Permalink to GitHub: https://github.com/simolus3/web3dart/blob/fe3b5be784318433994d16256964a4fa5de3d2fd/lib/src/utils/typed_data.dart#L9
/// This function is part of the library web3dart, licenesed under the MIT License https://github.com/simolus3/web3dart/blob/a97de62fbe8ccc04c29d3c726484cccd5a9522fe/LICENSE
Uint8List padUint8ListTo32(Uint8List data) {
  assert(data.length <= 32);
  if (data.length == 32) return data;

  return Uint8List(32)..setRange(32 - data.length, 32, data);
}

Uint8List randomBytes(int length, {bool secure = false}) {
  assert(length > 0);
  final Random random = secure ? Random.secure() : Random();
  final Uint8List ret = Uint8List(length);
  for (int i = 0; i < length; i++) {
    ret[i] = random.nextInt(256);
  }
  return ret;
}

BigInt getMaxNumber() {
  final BigInt base = BigInt.two;
  final BigInt power = base.pow(BigInt.from(256).toInt());
  final BigInt max = power - BigInt.one;
  return max;
}
