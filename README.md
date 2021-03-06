Log-CI
======

Simple CI script that writes build/test results into a log file.
Supports Git only (version 1.7.7.2 or later).

Installation
------------

Add a new user:

    adduser ci

Clone repo into /opt/log-ci and set permissions:

    cd /opt
    git clone git@github.com:rla/log-ci.git
    chown -R ci:ci /opt/log-ci

Create symlink:

    ln -sf /opt/log-ci/log-ci.sh /usr/local/bin/log-ci

Create log file:

    touch /opt/log-ci/log.txt
    chown ci:ci /opt/log-ci/log.txt

Usage
-----

Add project as ci user:

    cd ~
    git clone git@github.com:your_user/your_repo.git

Set up log-ci configuration:

    cd your_repo
    nano .log-ci-config

Configuration looks similar to:

    project="your_project"
    build="make ci"
    remote="origin"
    branch="master"

Tu run periodically, use cron:

    */10 * * * * log-ci ~/your_repo

Don't forget to properly set up PATH in the crontab file, example:

    PATH=/usr/local/bin:/usr/bin:/bin

License
-------

The MIT license.

```
Copyright (c) 2013 Raivo Laanemets

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.
```