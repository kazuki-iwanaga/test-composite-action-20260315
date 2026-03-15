.PHONY: test--composite--generate-values test--composite--render-manifest
test--composite--generate-values:
	act -P ubuntu-latest=catthehacker/ubuntu:act-24.04 -W .github/workflows/test__composite__generate-values.yaml
test--composite--render-manifest:
	act -P ubuntu-latest=catthehacker/ubuntu:act-24.04 -W .github/workflows/test__composite__render-manifest.yaml
