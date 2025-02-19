import 'dart:io';

import 'package:path/path.dart' as path;

import 'anthropic_client.dart';

/// Reads all .mdc files from the .cursor/rules directory
Future<String> _getRules() async {
  final rulesDir = Directory(path.join(
      path.dirname(Platform.script.toFilePath()), '..', '.cursor', 'rules'));

  if (!await rulesDir.exists()) {
    return '';
  }

  final rules = StringBuffer();
  await for (final entity in rulesDir.list()) {
    if (entity is File && path.extension(entity.path) == '.mdc') {
      rules.writeln('\n--- ${path.basename(entity.path)} ---');
      rules.writeln(await entity.readAsString());
    }
  }

  return rules.toString();
}

/// A script that sends the current git diff to Anthropic's API for analysis
Future<void> main(List<String> args) async {
  final includeStagedChanges = args.contains('--staged');

  // Get the API key from the file
  final apiKeyFile = File(path.join(
      path.dirname(Platform.script.toFilePath()), '..', 'anthropic_key.txt'));

  if (!await apiKeyFile.exists()) {
    print('Error: anthropic_key.txt not found');
    exit(1);
  }

  final apiKey = (await apiKeyFile.readAsString()).trim();
  final client = AnthropicClient(apiKey: apiKey);

  // Get cursor rules
  final rules = await _getRules();

  // Run dart analyze and capture output
  final analyzeResult = await Process.run('dart', ['analyze']);
  final analyzeOutput = analyzeResult.stdout as String;
  final analyzeError = analyzeResult.stderr as String;
  final hasAnalyzeIssues = analyzeResult.exitCode != 0;

  // Run git diff and capture output
  final unstagedResult = await Process.run('git', ['diff']);
  String unstagedDiff = '';
  String stagedDiff = '';

  if (unstagedResult.exitCode != 0) {
    print('Error running git diff: ${unstagedResult.stderr}');
    exit(1);
  }
  unstagedDiff = unstagedResult.stdout as String;

  if (includeStagedChanges) {
    final stagedResult = await Process.run('git', ['diff', '--cached']);
    if (stagedResult.exitCode != 0) {
      print('Error running git diff --cached: ${stagedResult.stderr}');
      exit(1);
    }
    stagedDiff = stagedResult.stdout as String;
  }

  final diff = [
    if (stagedDiff.isNotEmpty) '=== Staged Changes ===\n$stagedDiff',
    if (unstagedDiff.isNotEmpty) '=== Unstaged Changes ===\n$unstagedDiff',
  ].join('\n\n');

  if (diff.isEmpty) {
    print(
        'No ${includeStagedChanges ? "staged or " : ""}unstaged changes found');
    if (hasAnalyzeIssues) {
      print('\nDart Analyze Issues:\n$analyzeOutput$analyzeError');
      exit(1);
    }
    exit(0);
  }

  // Send to Anthropic for analysis
  try {
    final response = await client.sendMessage(
      message: '''
Project Rules and Standards:
$rules

Git Diff to Analyze:
$diff

Dart Analyze Output:
${analyzeOutput.isEmpty ? 'No analyses issues found' : analyzeOutput}${analyzeError.isEmpty ? '' : analyzeError}

You are a senior product manager and code quality expert reviewing code changes.
- Your task is to analyze this git diff against our project rules and best practices.
- Focus ONLY on identifying issues that require attention or changes.
- Be direct and concise, and specify exactly how you want the changes made in order for you to pass them. 
- If there are no issues, simply respond with "No issues found."
- Do not comment on issues with files that are not in the git diff.
- If you are unsure if something follows a rule because you need more context, do not consider it an issue, instead mention how you need more context, but continue to follow the "No issues found" rule.
- Ignore all issues related to universal-rule-acknowlegement
- Ignore all issues related to git commit messages, this is a pre commit check

Please analyze the changes and identify ONLY:
1. Violations of project rules or best practices
2. Required adjustments to meet standards
3. Critical quality or architectural concerns
4. Potential negative impacts on the codebase
5. Potential leaked keys or security issues
6. Issues identified by dart analyze

Format your response as a bullet list of issues that MUST be addressed.
Do not include compliments or positive feedback.

Only return 1 issue. If the same issue is identified in multiple places, list those places in the file part of the response.

Format your responses:
Issue:
<succinct issue & expectations to meet>
File: <file path>:<line number>
''',
      maxTokens: 1024,
    );

    print('\nCode Review Analysis:\n');
    var content = response['content'][0]['text'] as String;
    if (content.contains("No issues found") && !hasAnalyzeIssues) {
      // Stage all unstaged changes if analysis passes
      final stageResult = await Process.run('git', ['add', '.']);
      if (stageResult.exitCode != 0) {
        print('Error staging changes: ${stageResult.stderr}');
        exit(1);
      }
      print('Analysis passed. All changes have been staged.');
      exit(0);
    } else {
      print(content);
      print(
          "\nIf this complaint is non sensical, stop and ask for clarification.");
      exit(1);
    }
  } catch (e) {
    print('Error getting analysis: $e');
    exit(1);
  }
}
