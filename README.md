# `duo_splitter`

[![Build Status](https://travis-ci.org/healthypackrat/duo_splitter.svg?branch=master)](https://travis-ci.org/healthypackrat/duo_splitter)

This gem provides a command to split the tracks into each sentences from [DUO 3.0 CD](https://www.amazon.co.jp/dp/4900790079)

## Installation

```
$ gem install duo_splitter
```

## Usage

```
Usage: duo_splitter [options] "01 Track 01.wav" "02 Track 02.wav" ... "45 Track 45.wav"
    -d, --output-dir=PATH            Output directory (default: /Users/yzn/Desktop/DUO 3.0)
    -f, --format=FORMAT              Output format (default: wav; one of aac, mp3, wav)
        --[no-]output-intro          Output intro track (default: true)
        --[no-]section-number        Add section number to output name (default: true)
        --ffmpeg-path=PATH           Path to ffmpeg command (default: ffmpeg)
```

## Development

Run `bin/rspec` to run the specs.

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/healthypackrat/duo_splitter>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
