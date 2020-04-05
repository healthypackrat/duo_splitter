# duo\_splitter

[![Build Status](https://travis-ci.org/healthypackrat/duo_splitter.svg?branch=master)](https://travis-ci.org/healthypackrat/duo_splitter)

このgemに含まれているコマンドで[DUO 3.0 CD/**復習用**](https://www.amazon.co.jp/dp/4900790079)の音声を例文ごとに分割できます。

## 必要なもの

  - `ffmpeg`
      - `brew install ffmpeg`でインストールしてください
  - `sox`
      - `brew install sox`でインストールしてください
      - `repeating`コマンドと`overlapping`コマンドを実行する際に必要です

## インストール

```
$ gem install duo_splitter
```

## 使い方

### 準備

  1. WAVエンコーダを指定してCDをiTunesにインポートしてください。
  2. ターミナルを開いてインポートしたトラックがあるディレクトリへ移動してください。

### 単純な分割

以下のコマンドを実行すると`~/Desktop/DUO 3.0`に分割された音声が生成されます。

```
$ duo_splitter split *.wav
```

指定できるオプションを確認するには`duo_splitter split -h`を実行してください。

出力ディレクトリを変更するには`-d`オプションを指定してください:

```
$ duo_splitter split -d /path/to/dir *.wav
```

出力フォーマットを変更するには`-f`オプションを指定してください:

```
$ duo_splitter split -f mp3 *.wav
```

「SECTION 〜」の音声が不要な場合は`--no-output-intro`オプションを指定してください:

```
$ duo_splitter split --no-output-intro *.wav
```

出力されるファイル名にセクション番号を付けたくない場合は`--no-section-number`オプションを指定してください:

```
$ duo_splitter split --no-section-number *.wav
```

`ffmpeg`の場所を変更するには`--ffmpeg-path`オプションを指定してください:

```
$ duo_splitter split --ffmpeg-path=/path/to/ffmpeg *.wav
```

### リピーティング用の分割

以下のコマンドを実行すると`~/Desktop/DUO 3.0 (Repeating)`に分割された音声が生成されます。

```
$ duo_splitter repeating *.wav
```

生成された音声の最後には合図の音声と例文と同じ長さの無音の音声が追加されています。

指定できるオプションを確認するには`duo_splitter repeating -h`を実行してください。

合図の音声が不要な場合は`--no-notification-sound`オプションを指定してください:

```
$ duo_splitter repeating --no-notification-sound *.wav
```

合図の音声を変更するには`--notification-sound-path`オプションを指定してください:

```
$ duo_splitter repeating --notification-sound-path=/path/to/audio.wav *.wav
```

`sox`の場所を変更するには`--sox-path`オプションを指定してください:

```
$ duo_splitter repeating --sox-path=/path/to/sox *.wav
```

### オーバーラッピング用の分割

以下のコマンドを実行すると`~/Desktop/DUO 3.0 (Overlapping)`に分割された音声が生成されます。

```
$ duo_splitter overlapping *.wav
```

生成された音声の先頭には合図の音声が追加されています。

指定できるオプションを確認するには`duo_splitter overlapping -h`を実行してください。

合図の音声を変更するには`--notification-sound-path`オプションを指定してください:

```
$ duo_splitter repeating --notification-sound-path=/path/to/audio.wav *.wav
```

`sox`の場所を変更するには`--sox-path`オプションを指定してください:

```
$ duo_splitter repeating --sox-path=/path/to/sox *.wav
```

## 開発

テストするには`bundle install`を実行してから`bin/rspec`を実行してください。

## ライセンス

ライセンスは[MIT License](https://opensource.org/licenses/MIT)です。
