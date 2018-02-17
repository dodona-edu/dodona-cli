#!/bin/bash
result=$(gem build dodona-cli)
echo "$result"
file=$(echo "$result" | sed -n 's/\s*File:\s*\(dodona-cli.*\)/\1/p')
gem install --local "$file"
