#!/usr/bin/env bash

assert_equal() {
  if [ "$1" != "$2" ]; then
    echo "Expected: $1"
    echo "Actual:   $2"
    return 1
  fi
}

assert_range() {
  if [ $1 -lt $2 ]; then
    echo "Expected: $1"
    echo "Greater than: $2"
    return 1
  fi
  if [ $1 -gt $3 ]; then
    echo "Expected: $1"
    echo "Less than: $3"
    return 1
  fi
}

assert_output() {
    assert_equal "$1" "$output"
}

assert_success() {
  if [ "$status" -ne 0 ]; then
    echo "Command failed with exit status $status"
    return 1
  elif [ "$#" -gt 0 ]; then
    assert_output "$1"
  fi
}

assert_fail() {
  if [ "$status" -eq 0 ]; then
    echo "Command succeeded, but should fail"
    return 1
  elif [ "$#" -gt 0 ]; then
    assert_output "$1"
  fi
}

# $1 expected filename
assert_file_exists() {
  assert_success
  if [ ! -e "$1" ]; then
    echo "Expected file: $1"
    return 1
  fi
}

# Currently, this is a crude process that looks for a marker term, a space
# and then the value looking to be found.

# $1 filename being asserted
# $2 term being searched for
# $3 expected value to be found
assert_exists_in_file() {
  assert_file_exists $1
  actual=$(grep $2 $1 | cut -f2 -d ' ')
  assert_equal "$3" "$actual"
}
