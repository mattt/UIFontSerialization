UIFontSerialization
===================

`UIFontSerialization` encodes and decodes between `UIFont` and Postscript font data, following the API conventions of Foundation's `NSJSONSerialization` class.

## Usage

### Decoding

```objective-c
NSURL *fontFileURL = [[NSBundle mainBundle] URLForResource:@"font" withExtension:@"tty"];
NSData *data = [NSData dataWithContentsOfURL:fontFileURL];
UIFont *font = [UIFontSerialization fontWithData:data error:nil];
```

### Encoding

```objective-c
UIFont *font = [UIFont systemFontOfSize:24]
NSData *data = [UIFontSerialization dataWithFont:font error:nil];
```

---

## Contact

Mattt Thompson

- http://github.com/mattt
- http://twitter.com/mattt
- m@mattt.me

## License

UIFontSerialization is available under the MIT license. See the LICENSE file for more info.
