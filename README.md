# Github Runner as a Docker Image

No ports to expose. Set ENVs for:
- `REPO` for which the runner is meant to run for (format: _owner/repository_)
- `TOKEN` a personal access token with access to `workflow` and `admin:org`
