# Hashi2Cybr Migration Starter

<!-- Update: <2023-09-18 17:28:46 david.hisel> -->

## Introduction -- THIS IS A DRAFT IMPLEMENTATION

This implementation will help to show what is possible to get the
secrets from HC Vault to PAS Vault.

This repo will demonstrate a simple way to migrate Hashi Vault KV secrets into PAS Vault accounts.

## Quick Start

### PRE REQUIREMENTS

* PAS Vault
  * Create a safe in PAS Vault named "Pending"
  * Duplicate "Unix via SSH" platform and give it the name "Migration Platform"
* Local machine
  * [Install podman](https://podman.io/docs/installation)
  * [Install GNU make](https://www.gnu.org/software/make/)

### Implementation Steps

1. In PAS UI (aka PVWA):
   1. Create a safe named "Pending"
   2. Go to "Administration" -> "Platform Management", then expand the "Unix" platform.
   3. Duplicate the "Unix via SSH" platform and give it the name "Migration Platform"
2. Clone this repo:  <https://github.com/davidh-cyberark/charon-punt>
   1. Copy `local.env.example` to `local.env`
   2. Edit `local.env` and fill in the appropriate values
   3. Build the container, run `make build`
   4. Run the container and enter credentials when prompted, run `make run`
      * MUST use `--rm` -- since this is sensitive data, we want to remove the container when done
      * MUST mount `local.env` file -- container should only access this info and not store it
      * MUST mount `/data` as a tmpfs -- tmpfs (aka, RAM disk) will mount here

### Usage

#### Building and Running

The [pre requirements](#pre-requirements) must be in place before building and running.


```bash
make build # this might take a couple minutes

# Run the container in podman -- see Makefile for full podman command
make run
```

## Repo(s)

* <https://github.com/davidh-cyberark/charon-punt>
* <https://github.com/davidh-cyberark/vault-safe-cli.git>

## COLOPHON

Charon is the ferryman on the river Styx.

A punt is the type of boat that Charon used.

https://en.wikipedia.org/wiki/Punt_(boat)

## Contributing

No outside contributions are expected for this repo.

## License

```text
    Copyright (c) 2023 CyberArk Software Ltd. All rights reserved.
    
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
       http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
```

For the full license text see [`LICENSE`](LICENSE).
