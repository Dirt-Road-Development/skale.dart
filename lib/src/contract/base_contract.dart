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
/// @file base_contract.dart
/// @author Sawyer Cutler
/// @copyright Dirt Road Development 2022-Present
///
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class BaseContract {
  late Web3Client client;
  late DeployedContract contract;

  BaseContract(
      ContractAbi abi, EthereumAddress contractAddress, String rpcUrl) {
    contract = DeployedContract(abi, contractAddress);
    client = Web3Client(rpcUrl, Client());
  }
}
