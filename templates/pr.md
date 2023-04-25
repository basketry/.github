### Context

The Basketry organization contains many repositories. The repository workflows are backed by shared workflows; however, there is a bit of boilerplate needed to call those shared workflows. The shared workflows can be found in the [`basketry/workflows`](https://github.com/basketry/workflows/tree/main/.github/workflows) repository.

### Change

This change updates the boilerplate workflows in this repository.

### Consequences

- All builds in the repository will run per the latest workflow boilerplate.
- All changes to shared workflows will continue to automatically to be leveraged by this repository.
