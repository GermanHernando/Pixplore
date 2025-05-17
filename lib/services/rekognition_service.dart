import 'dart:convert';
import 'dart:typed_data';
import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';

import '../core/aws_credentials.dart';

class RekognitionService {
  static final _region = awsRegion;
  static final _host = 'rekognition.$_region.amazonaws.com';
  static final _endpoint = Uri.https(_host, '/');

  Future<List<String>> detectLabels(Uint8List imageBytes) async {
    final credentials = AWSCredentials(accessKey, secretKey);

    final signer = AWSSigV4Signer(
      credentialsProvider: AWSCredentialsProvider(credentials),
    );

    final payload = jsonEncode({
      'Image': {'Bytes': base64Encode(imageBytes)},
      'MaxLabels': 10,
      'MinConfidence': 75.0,
    });

    final awsRequest = AWSHttpRequest(
      method: AWSHttpMethod.post,
      uri: _endpoint,
      headers: {
        AWSHeaders.host: _host,
        AWSHeaders.contentType: 'application/x-amz-json-1.1',
        AWSHeaders.target: 'RekognitionService.DetectLabels',
      },
      body: utf8.encode(payload),
    );

    final signedRequest = await signer.sign(
      awsRequest,
      credentialScope: AWSCredentialScope(
        region: _region,
        service: AWSService.rekognition,
      ),
    );

    final operation = await signedRequest.send();
    final response = await operation.response;
    final responseBody = utf8.decode(await response.bodyBytes);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(responseBody);
      final labels = jsonResponse['Labels'] as List<dynamic>;
      return labels.map((e) => e['Name'].toString()).toList();
    } else {
      throw Exception('Error de Rekognition: $responseBody');
    }
  }
}
