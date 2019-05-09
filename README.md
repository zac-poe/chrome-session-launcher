# Chrome Session Launcher
This project is a wrapper utility for launching multiple independent Chrome Browser sessions.

This tool can be useful for operations like simultaneously cross comparing different user logins on a site.

# Sample Usage
Usage can be simplified by including this script in your path, such as `ln -s {path-to-project}/chrome-session.sh /usr/local/bin/chrome-session`.

`chrome-session -s 1` - launch session 1. Any state supporting the browser (user sessions, caches, cookies, etc) will be fully independent of your normally launched Chrome browser  
`chrome-session 1` - shorthand, same as above.

`chrome-session -s 2` - launch session 2. Session 2 will be independent of your normally launched Chrome browser, session 1, etc

`chrome-session` - launching without any specified session will effectively be the same as normally launching Chrome
