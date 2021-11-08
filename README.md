# Demo: Parcel 2 dev server + Docker file watching issue

Parcel 2 running in a standard Node.js Docker container does not detect changes in files on a mounted volume when they are updated from the host and thus does not rebuild the project it is serving. This prevents us from effectively using Parcel 2 in development.

This repo offers a is a minimal-setup reproduction of the issue to help debug and assess possible workarounds or fixes.

To see the problem:

Requirement: Docker

1. Run `docker compose up --build`
2. Edit a file in `src` directory from the host machine
    - Ensure you're not using an editor that uses "safe write" ([reference](https://parceljs.org/features/development#safe-write))
3. Observe that Parcel 2 does not see the file change and does not rebuild the project

Note that Parcel 2's server *will* see the file change and will successfully rebuild if you `touch` the file from within the container itself. To see this, make the change as above and notice that Parcel doesn't rebuild, then run:

```
docker exec $(docker ps --filter "name=parcel2" --quiet) touch /app/src/animals.js
````

and note that Parcel now immediately rebuilds the project successfully.

This has been tested on Mac OS 10.15.7 with Docker Desktop 4.1.1 (69879)
