#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function test
{
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NONE='\033[0m'

    if [ $(echo "$2" | grep "$3" | wc -l) -gt 0 ]; then
        echo -e " ${GREEN}Passed: ${NONE}$1"
    else
        echo -e " ${RED}Failed: ${NONE}$1"
    fi
}

# start nginx
nginx -c $DIR/nginx.conf

# tests
test "no header Authorization" "$(curl -v http://localhost:8081 2>&1)" "401 Unauthorized"
test "no Bearer token"         "$(curl -v -H "Authorization: BBBBBB eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzaHVhaWNqIiwicm9sZXMiOlsiUk9MRV9VU0VSIl19.RbpK_R1BsgqcgBVEXHSdEy6FCqADgaCSyKZlrfN5CJI" http://localhost:8081 2>&1)" "401 Unauthorized"
test "not role ADMIN"          "$(curl -v -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzaHVhaWNqIiwicm9sZXMiOlsiUk9MRV9VU0VSIl19.RbpK_R1BsgqcgBVEXHSdEy6FCqADgaCSyKZlrfN5CJI" http://localhost:8081 2>&1)" "403 Forbidden"
test "role ADMIN"              "$(curl -v -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsInJvbGVzIjpbIlJPTEVfQURNSU4iLCJST0xFX1VTRVIiXX0.tpDXvhmxmqozzYOQJVZbUObUzpGFfxLMuLXGMLeVhJQ" http://localhost:8081 2>&1)" "200 OK"

# stop nginx
nginx -s stop
