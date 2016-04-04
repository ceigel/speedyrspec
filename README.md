# Speedy RSpec

Faster testing by running only the needed tests.

## Description

Speedy RSpec computes which tests are relevant for certain code changes. It
does this by tracing all calls during a test run and saving for each test all
the files which are seen. At runtime it uses this file to compute which tests
offer coverage for a particular file.

## Install

```ruby gem 'speedyrspec' ```

## Configuration

Set path for the trace_file. This is where SpeedyRspec stores its dependency
graph.

```ruby speedyrspec.configure do |config| config.trace_file =
'speedy_traces.json' end ```

## Usage

In order to compute the smallest amount of tests needed to be run, the
following steps shouldbe followed.

1. Compute dependency graph. This stores in the trace_file the dependency list
   of each file. This process is best repeated weekly.

```bash rake speedyrspec:collect ```

2. Run tests for the changed files.

  2.1 Tests for app files.

  ```bash rake speedyrspec:run <app/files> ```

  2.2. Tests from git changes. Load list of changed files and compute which
  tests to run.

  ```bash rake speedyrspec:run:git ```
