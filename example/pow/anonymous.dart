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

import 'package:skale/skale.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';

Future<void> main() async {
  AnonymousPow pow = AnonymousPow(AnonymousParams(
      "https://staging-v3.skalenodes.com/v1/staging-utter-unripe-menkar",
      null));

  await pow.send(TransactionParams(
      to: EthereumAddress.fromHex("0xa9eC34461791162Cae8c312C4237C9ddd1D64336"),
      data: hexToBytes(
          "0x0c11dedd000000000000000000000000Da11eC5944D960008A3184Cc7F4A9C001b3B2Cff")));
}
