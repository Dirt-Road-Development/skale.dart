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
/// @file miner.dart
/// @author Sawyer Cutler
/// @copyright Dirt Road Development 2022-Present

import 'package:skale/skale.dart';
import 'package:test/test.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

const CASE_1_BYTES =
    "fcb3959dd0f53c43ae680f6251868d60147f6b7f2fe767743d3e525def0e2eb6";

void main() {
  group('Matching SKALE.js Tests', () {
    final miner = SkalePowMiner(null);

    test('Case 1', () async {
      BigInt mine = miner.mineFreeGas(
          21000,
          EthereumAddress.fromHex("0x0000000000000000000000000000000000000000"),
          0,
          hexToBytes(CASE_1_BYTES));
      expect(
          mine,
          equals(BigInt.parse(
              "-1491953154814595559522385770564693355476610316307305530128735383911436243274")));
    });
  });
}
