# nginx-jwt-verify
Nginx JWT verification.

#### Configurations
- **8080-http.conf** - http server
- **8081-jwt-verify.conf** - jwt token verification

#### Get Started
1. Install Nginx with lua support.
```
$ brew tap homebrew/nginx
$ brew install nginx-full --with-lua-module --with-set-misc-module
```
2. Install lua JWT related modules.
```
$ brew install lua@5.1
$ luarocks-5.1 install lua-cjson
$ luarocks-5.1 install lua-resty-jwt
$ luarocks-5.1 install lua-resty-string
```
3. Run all tests.
```
$ ./run-tests.sh
```
