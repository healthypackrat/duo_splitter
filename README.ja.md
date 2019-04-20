# `duo_splitter`

[![Build Status](https://travis-ci.org/healthypackrat/duo_splitter.svg?branch=master)](https://travis-ci.org/healthypackrat/duo_splitter)

このgemに含まれているコマンドで[DUO 3.0 CD/**復習用**](https://www.amazon.co.jp/dp/4900790079)の音声を例文ごとに分割できます。

## 必要なもの

  - ffmpeg
      - `brew install ffmpeg`でインストールしてください

## インストール

```
$ gem install duo_splitter
```

## 使い方

まずは、WAVエンコーダを指定してCDをiTunesにインポートしてください。

次に、ターミナルを開いてインポートしたトラックがあるディレクトリへ移動してください。

以下のコマンドを実行すると`~/Desktop/DUO 3.0`に分割された音声が生成されます。

```
$ duo_splitter *.wav
```

`duo_splitter -h`を実行すると、コマンドに指定できるオプションを確認できます。

## 開発

テストするには`bin/rspec`を実行してください。

## ライセンス

ライセンスは[MIT License](https://opensource.org/licenses/MIT)です。
