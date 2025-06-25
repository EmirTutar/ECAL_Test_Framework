# eCAL Test Framework

This repository contains an automated integration test framework for [eCAL](https://github.com/eclipse-ecal/ecall). It is designed to run and validate communication scenarios between multiple processes using eCAL middleware.

- View status and logs of last tests:

    https://github.com/EmirTutar/ECAL_Test_Framework/actions

- Test report (available after completion of the tests):
    
    https://emirtutar.github.io/ECAL_Test_Framework/

## Purpose

The main goal of this project is to provide:

* Automated test runs on push, pull request, or schedule
* Reliable feedback on message communication and process stability
* Visual test reports for easy inspection

## Features

* Supports multiple eCAL transport layers (SHM, UDP, TCP)
* Covers common scenarios such as:

  * Publisher to Subscriber communication
  * Multi-publisher and multi-subscriber setups
  * Fault injection (e.g., crashing subscribers or publishers)
  * Network failure simulations
* Test results are published to GitHub Pages
* Integration in eCAL repositori via `repository_dispatch`

## Test Scenarios

Each test case is implemented using [Robot Framework](https://robotframework.org/), with Docker-based isolation.

Available scenarios include:

* `basic_pub_sub`
* `multi_pub_sub`
* `network_crash`
* `pub_crash`
* `sub_crash`
* `sub_send_crash`
* and more...

## Test Reports

Test results are automatically deployed to:
👉 [https://emirtutar.github.io/ECAL\_Test\_Framework](https://emirtutar.github.io/ECAL_Test_Framework)

Each run is timestamped and archived, with access to:

* `log.html`
* `report.html`
* `output.xml`

## Triggering Tests

Tests can be triggered in three ways:

1. Manually via GitHub Actions
2. Automatically from the eCAL repository using `repository_dispatch` (Create a PR or Push to Master)

## Note for Forks

If you are working on a fork of the official eCAL repository (e.g., UserName/ecal) and you create a pull request or push from develop to master within your fork, you need to allow GitHub Actions to trigger the integration tests in this repository.

To do so, follow these steps:

### 1. Create a Personal Access Token (PAT):
1. Go to your GitHub Developer Settings → Personal Access Tokens.
2. Click on “Generate new token (classic)”.
3. Set a name like ECAL Test Trigger Token.
4. Set an expiration (e.g., 90 days or custom).
5. Under Scopes, enable:
 - repo (for private forks)
 
    or

 - public_repo (for public forks only)

6. Click Generate token and copy it immediately. You won't see it again.

### 2. Add the Token to Your Forked eCAL Repository:
1. Go to your forked repository on GitHub (e.g., UserName/ecal).
2. Navigate to: Settings → Secrets and variables → Actions → New repository secret.
3. Name the secret exactly:

```bash
TEST_FRAMEWORK_TOKEN
```
4. Paste the copied token as the value.
5. Click Add secret.
6. Once added, GitHub Actions in your fork can use this token to trigger the test framework via repository_dispatch.

⚠️ This is only needed for forks. If you push or create PRs directly in eclipse-ecal/ecal, no token is required.

## Feedback to eCAL Repo

After the test run finishes, the result (pass/fail) is reported back to the original commit in the eCAL repository as a commit status.

## Requirements

* eCAL (If you build without Docker)
* Docker
* Python 3
* Robot Framework

## Structure

```
integration_tests/
  ├── basic_pub_sub/
  ├── multi_pub_sub/
  ├── network_crash/
  ├── pub_crash/
  ├── sub_crash/
  ├── sub_send_crash/
  ├── lib/
  └── docker/
        └── Dockerfile.ecal_base
```

## License
eCAL Test Framework is licensed under Apache License 2.0. You are free to

- Use eCAL Test Framework commercially
- Modify eCAL Test Framework
- Distribute eCAL Test Framework
