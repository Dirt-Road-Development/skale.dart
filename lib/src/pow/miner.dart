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

import 'dart:typed_data';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:skale/src/utils/shared.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class SkalePowMinerParams {
  late BigInt difficulty;

  SkalePowMinerParams(BigInt? optionalDifficulty) {
    difficulty = optionalDifficulty ?? BigInt.one;
  }
}

class SkalePowMiner {
  BigInt difficulty = BigInt.one;

  SkalePowMiner(SkalePowMinerParams? params) {
    if (params != null) difficulty = params.difficulty;
  }

  Future<BigInt> mineGasForTransaction(
      int nonce, int gas, EthereumAddress from, Uint8List? bytes) async {
    return mineFreeGas(gas, from, nonce, bytes);
  }

  Future<BigInt> mineFreeGas(
      int gasAmount, EthereumAddress from, int nonce, Uint8List? bytes) async {
    final int gasAmountInt = gasAmount.toInt();
    final BigInt nonceHash =
        bytesToInt(AbiUtil.soliditySHA3(["uint256"], [nonce]));
    final BigInt addressHash =
        bytesToInt(AbiUtil.soliditySHA3(["address"], [from.addressBytes]));
    final BigInt nonceAddressXOR = nonceHash ^ addressHash;
    final BigInt maxNumber = getMaxNumber();
    final BigInt divConstant = BigInt.from(maxNumber / difficulty);
    BigInt candidate;

    int iterations = 0;

    while (true) {
      candidate =
          bytesToInt(padUint8ListTo32(bytes ?? randomBytes(32, secure: true)));
      BigInt candidateHash =
          bytesToInt(AbiUtil.soliditySHA3(["uint256"], [candidate]));
      BigInt resultHash = nonceAddressXOR ^ candidateHash;
      double externalGas = divConstant / resultHash;

      if (externalGas >= gasAmountInt) {
        break;
      }

      if (iterations++ % 2000 == 0) {
          await Future.delayed(Duration.zero);
      }
    }

    return candidate;
  }
}
