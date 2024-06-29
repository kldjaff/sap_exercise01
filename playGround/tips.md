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

# Install postgres and related package for development.

## Install postgress on your macbook

```shell
$ brew install postgresql
```
If you want to start the postgres database, please run the follow command.

```shell
$ brew services start postgresql@14
```

If you want to remove this service out of the startup application instead of using docker postgres db. You can run script like:

```shell
$ /opt/homebrew/opt/postgresql@14/bin/postgres -D /opt/homebrew/var/postgresql@14
```
## Install DBI and DBD::Pg on your macbook.

### Suggestion from the internet resource.

```shell
$ cpanm DBI
$ cpanm DBD::Pg
```
### Unfortunately, I wasn't able to install DBI and DBD::Pg by using the recommended method. Maybe the following steps can help you out.

1. Go to [CPAN DBI page](https://metacpan.org/pod/DBI), [CPAN DBD::Pg page](https://metacpan.org/pod/DBD::Pg) Download the installation files.
2. Unzip the files in your `Downloads` folder, you will get tow folders: `DBI-1.643`, `DBD-Pg-3.18.0`
3. Open a terminal and enter t he folder `DBI-1.643`, There is a file named `README.md` to install it manually.
4. Install DBD::Pg, I met problem
```
`/system/library/perl/extras/5.34/darwin-thread-multi-2level/auto/dbi/driver_xst.h', needed by `pg.xsi'. stop.
```
But this driver_xst.h is in the folder `DBI-1.643`. Somehow, while install the DBI package the related .h files couldn't be installed.
  - Then you have to enter the folder `DBD-Pg-3.18.0`, you can't follow the `README.md` to install properly. You have to make some changes in the make file.
  ```shell
  $ perl Makefile.PL      # This will help to generate the makefile, You able to make this step success.
  ```
  - Then you will see a `Makefile` generated, Then you need to change this file, because you have to add the -I{The full path of `DBI-1.643`} in each of the `-I` lines.
  - Then you can run `make` and `make install` to finish the installation. 