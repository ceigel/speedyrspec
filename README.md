# Speedy RSpec

Faster testing by running only the needed tests.

## Description

Speedy RSpec computes which tests are relevant for certain code changes. It
does this by tracing all calls during a test run and saving for each test all
the files which are seen. At runtime it uses this file to compute which tests
offer coverage for a particular file.

## Install

```ruby
gem 'speedyrspec'
```

## Configuration

Set path for the trace_file. This is where SpeedyRspec stores its dependency
graph.

```ruby
SpeedyRspec.configure do |config|
  config.trace_file = 'speedy_traces.json'
end
```

## Usage

In order to compute the smallest amount of tests needed to be run, the
following steps should be followed.

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

  2.2. Tests from git changes. Load list of changed files and compute which
  tests to run.

  ```bash
  rake speedyrspec:run:git
  ```

## Recommended setup

It is recommended to periodically collect traces. This can be done weekly in a
test run followed by a commit of the traces file into your repository. This is
possible with a configuration similar to the following:

```ruby
SpeedyRspec.configure do |config|
  config.trace_file = 'speedy_traces.json'
end
```

Another option is to write the traces file in S3 bucket set-up for static
hosting. At trace-collection the AWS access credentials will have to be stored
in the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.
