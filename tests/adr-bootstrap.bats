#!/usr/bin/env bats

load test_helper

# setup() {
#   mkdir -p "target"
#   mkdir -p "expected_target"
# }

# function teardown() {
#   if [[ -d "../doc" ]]; then
#     rm -rf "../doc"
#   fi
#   echo "teardown..."
# }

@test "Should display help text when no arguments provided" {
  run make
  assert_success

  assert_equal "${lines[0]}"  "Architectural Decision Record (ADRs) task generator"
  assert_equal "${lines[1]}"  "Options:"
  assert_equal "${lines[2]}"  " adr                            : Generate a new ADR readme index and graph."
  assert_equal "${lines[3]}"  " adr-new DECISON=\"new decision\" : Generator a new decision record"
  assert_equal "${lines[4]}"  " adr-graph (optional)           : Dynamically generic the visual graph of of the ADRs"
  assert_equal "${lines[5]}"  " adr-readme (optional)          : Dynamically generate the ADR readme."
}

@test "Should verify dependencies are installed." {
    run make pre-init
    assert_success

    assert_equal "${lines[0]}"  "Dependencies installed!"
}

@test "Should generate new README.md" {
  run make adr
  assert_file_exists "doc/architecture/decisions/README.md" 
}

@test "Should generate a graph.dot" {
  run make adr-graph
  assert_file_exists "doc/architecture/decisions/graph.dot"
}

@test "Should generate a graph.png" {
  run make adr-graph
  assert_file_exists "doc/architecture/decisions/graph.png" 
}

@test "Should create first decision to use ADRs" {
  run make adr-init
  assert_file_exists "doc/architecture/decisions/0001-record-architecture-decisions.md" 
}

@test "Should create a new decision" {
  run make adr-new DECISION="new decision"
  assert_file_exists "doc/architecture/decisions/0002-new-decision.md" 
}

@test "Should create a new decision with a British date format" {
  todays_date=$(date +%d-%m-%Y)
  run make adr-new DECISION="new decision"
  assert_exists_in_file "doc/architecture/decisions/0001-record-architecture-decisions.md" "Date" "$todays_date"
}
