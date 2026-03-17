#!/usr/bin/env bash
# xbar doesn't inherit shell PATH; add Homebrew for both Intel and Apple Silicon
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

jrnl working -1 -from "1 hour ago" --format "json" | jq .entries[].title
