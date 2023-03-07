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
/// @file wallet.dart
/// @author Sawyer Cutler
/// @copyright Dirt Road Development 2022-Present

import "dart:math";
import "dart:typed_data";

import "package:http/http.dart";
import "package:web3dart/credentials.dart";
import "package:web3dart/web3dart.dart"
    show EthPrivateKey, EtherAmount, EtherUnit, Transaction, Wallet, Web3Client;

import "./miner.dart";

class WalletParams extends SkalePowMinerParams {
  final String rpcUrl;
  final EthPrivateKey privateKey;

  WalletParams(BigInt? difficulty,
      {required this.rpcUrl, required this.privateKey})
      : super(difficulty);
}

class TransactionParams {
  EthereumAddress to;
  Uint8List data;
  int? gas;
  Uint8List? bytes;

  TransactionParams(
      {required this.to, required this.data, this.gas, this.bytes});
}

class WalletPow extends SkalePowMiner {
  late Wallet wallet;
  late Web3Client client;

  WalletPow(WalletParams params) : super(params) {
    client = Web3Client(params.rpcUrl, Client());
    wallet = Wallet.createNew(params.privateKey, "", Random.secure());
  }

  Future<String> send(TransactionParams params) async {
    int nonce = await client.getTransactionCount(wallet.privateKey.address);

    BigInt gasHash = mineFreeGas(
        params.gas ?? 100000, wallet.privateKey.address, nonce, params.bytes);

    Transaction tx = Transaction(
        from: wallet.privateKey.address,
        to: params.to,
        data: params.data,
        gasPrice: EtherAmount.fromBigInt(EtherUnit.wei, gasHash));

    return await client.sendTransaction(wallet.privateKey, tx,
        chainId: null, fetchChainIdFromNetworkId: true);
  }
}
