# Install Perl on Mac
```shell
$ brew install perl
```

# Install LanguageSerer for vscode
```shell
$ brew install cpanm
$ cpanm --force AnyEvent::AIO
$ cpanm --force Coro
$ cpanm Perl::LanguageServer
```
After that restart the vscode.

# Config vscode settings

Input those paths into the perlInc in `settings.json`

```
  "perl.perlInc": ["/Users/<username>/perl5/lib/perl5/5.30.3/darwin-thread-multi-2level",
                   "/Users/<username>/perl5/lib/perl5/5.30.3",
                   "/Users/<username>/perl5/lib/perl5/darwin-thread-multi-2level",
                   "/Users/<username>/perl5/lib/perl5"]
```

Restart vscode.

# Optional

You also can change the `launch.json`

```
...
"stopOnEntry": false,
...
```

You can happly use `F5` to run your code.