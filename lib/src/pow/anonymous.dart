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
/// @file anonymous.dart
/// @author Sawyer Cutler
/// @copyright Dirt Road Development 2022-Present

import "dart:math";

import "package:skale/src/pow/wallet.dart";
import "package:web3dart/credentials.dart";

class AnonymousParams extends WalletParams {
  AnonymousParams(String rpcUrl, BigInt? difficulty)
      : super(difficulty,
            rpcUrl: rpcUrl,
            privateKey: EthPrivateKey.createRandom(Random.secure()));
}

class AnonymousPow extends WalletPow {
  AnonymousPow(AnonymousParams params) : super(params);
}
