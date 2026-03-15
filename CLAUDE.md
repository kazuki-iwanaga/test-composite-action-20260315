# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

基本的な情報は [README.md](README.md) を参照してください。

## 設計意図

Cloud Runのservice.yamlを動的生成するComposite Actionを2層構造で実装：

- **generate-values**: 入力→values.json（jqによる安全なパース）
- **render-manifest**: values.json→service.yaml（Helm template）

**重要な設計判断:**
- 配列データ（env-varsなど）はJSON文字列またはkey=value形式（改行区切り）で受け取る
  - JSON形式: `[{"name": "KEY", "value": "val"}]`
  - key=value形式: `KEY1=val1\nKEY2=val2`（空行に対応）
  - 形式は先頭文字が`[`かどうかで自動判定
- 中間ファイルはJSON形式（BashでのYAML生成は脆弱性の原因）
- 各アクションは自己完結（関連リソースを同ディレクトリに配置）

## テスト戦略

スナップショットテスト（diffで検証）

## 開発フロー

**重要**: コマンド実行は必ずMakefile経由で行うこと。

### テスト実行

```bash
make test--composite--generate-values   # generate-valuesのテスト
make test--composite--render-manifest   # render-manifestのテスト
```

### 新しいコマンドを追加する場合

MakefileにPHONYターゲットとして追加し、本ファイルにも記載すること。

## Claude Code設定

プロジェクトでは[.claude/settings.json](.claude/settings.json)で`make`コマンドを許可しています。新しいMakefileターゲットを追加する場合、settings.jsonの更新は不要です。

## 開発時の注意

- 設計変更や学んだことは本ファイルに随時更新
- README.mdにはユーザー向け情報、CLAUDE.mdには開発者向けナレッジ
