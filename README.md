# Github Runner as a Docker Image

A self-hosted runner for Github actions in the for of a Docker container. 

1. Pull and Run the container

> Set ENVs for:
>- `REPO` for which the runner is meant to run for (format: "_owner/repository_")
>- `TOKEN` a personal access token with access to `workflow` and `admin:org`

2. Make use of it in your workflows

> Set the `runs-on` parameters of your workflow from "_ubuntu-latest_" or other to "_self-hosted_"

3. Profit
