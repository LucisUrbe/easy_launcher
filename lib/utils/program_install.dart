import 'dart:io';
import 'dart:convert';
import 'package:easy_launcher/constants/global.dart' as global;

Future<int> platformDiskFreeBytes(String programPath) async {
  if (Platform.isMacOS) {
    Process process = await Process.start('df', ['-k', programPath]);
    final List<String> dfStdOut =
    await process.stdout.transform(utf8.decoder).toList();
    RegExp regExp = RegExp(r'^\S+\s+\d+\s+\d+\s+(\d+)');
    Match? match = regExp.firstMatch(dfStdOut[0].split('\n')[1]);
    if (match != null && match.groupCount >= 1) {
      return int.parse(match.group(1)!) * 1024;
    } else {
      throw const FormatException('Could not parse output from df!');
    }
  }
  return -1;
}

class ZipPackage {
  late final String url;
  late final String md5;
  late final int size;
  late final int decompressedSize;

  ZipPackage({
    required this.url,
    required this.md5,
    required this.size,
    required this.decompressedSize,
  });
}

Future<void> programInstall(
  Map<String, dynamic> mergedData,
  String biz,
  String programPath,
) async {
  // Collect basic information about the packages.
  List<ZipPackage> zipPackages = [];
  String programVersion = '';
  if (mergedData.containsKey('game_packages')) {
    List<Map<String, dynamic>> gamePackages = mergedData['game_packages'];
    for (Map<String, dynamic> gP in gamePackages) {
      if (gP['game']['biz'] == biz) {
        programVersion = gP['main']['major']['version'];
        for (Map<String, dynamic> major in gP['main']['major']['game_pkgs']) {
          zipPackages.add(ZipPackage(
            url: major['url'],
            md5: major['md5'],
            size: int.parse(major['size']),
            decompressedSize: int.parse(major['decompressed_size']),
          ));
        }
        break;
      }
    }
  }
  // Check if the device has enough space for the installation.
  int packagesBytes = 0;
  for (ZipPackage zP in zipPackages) {
    packagesBytes += zP.size;
  }
  int freeBytes = await platformDiskFreeBytes(programPath);
  if (packagesBytes > freeBytes) {
    throw const FileSystemException('Disk space not enough for download!');
  }
  // We expect that the whole installation task takes 25% more space.
  if (packagesBytes * 1.25 > freeBytes) {
    throw const FileSystemException('Disk space not enough for install!');
  }
  // Use Dio to download zip packages. (Aria2 may be better?)
  for (ZipPackage zP in zipPackages) {
    await global.dio.download(
      zP.url,
      programPath + zP.url.split('/').last,
      onReceiveProgress: (int received, int total) {
        if (total <= 0) return;
        // TODO: tell the status to a LinearProgressIndicator
      },
    );
  }
  // Calculate and check the MD5 hashes of the downloaded packages.
  // Decompress the zip packages.
  // Set the installation state and remove zip packages.
  // Write a config file.
}
