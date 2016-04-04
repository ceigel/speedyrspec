# Speedy RSpec

Faster testing by running only the tests exercising certain code.

## Description

Speedy RSpec computes which tests are relevant to run for a certain code
change. It does this by computing first the dependency graph during a test run
and using that to compute which tests are needed for a certain change.

## Install

```ruby
gem 'speedyrspec'
```

## Configuration

Set path for the trace_file. This is where SpeedyRspec stores its dependency graph.

```ruby
speedyrspec.configure do |config|
  config.trace_file = 'speedy_traces.json'
end
```

## Usage

In order to compute the smallest amount of tests needed to be run, the
following steps shouldbe followed.

1. Compute dependency graph. This stores in the trace_file the dependency list
   of each file. This process is best repeated weekly.

```bash
rake speedyrspec:collect
```

2. Run tests for the changed files.

  2.1 Tests for app files.

  ```bash
  rake speedyrspec:run <app/files>
  ```

  2.2. Tests from git changes. Load list of changed files and compute which tests to run.

  ```bash
  rake speedyrspec:run:git
  ```
