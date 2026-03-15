# Cloud Run Service YAML Generator

GitHub ActionsのComposite Actionを用いてCloud Runのservice.yamlを動的生成します。

## アーキテクチャ

2つのComposite Actionにより、入力からCloud Runマニフェストを生成します：

1. **generate-values**: ユーザー入力をjqで安全にパースし、values.jsonを生成
2. **render-manifest**: values.jsonとHelmチャートを結合し、service.yamlをレンダリング

## 使用方法

Reusable Workflow内での使用を想定しています。

```yaml
- name: Generate values
  id: values
  uses: ./.github/actions/generate-values
  with:
    service-name: my-service
    image: nginx:latest
    env-vars: '[{"name":"ENV","value":"prod"}]'

- name: Render manifest
  uses: ./.github/actions/render-manifest
  with:
    values-file: ${{ steps.values.outputs.values-path }}
```

## テスト

スナップショットテストを採用しており、期待値ファイルとのdiffで検証します。
