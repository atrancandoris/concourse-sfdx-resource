# Readme

Build this resource type:

```
docker build . -t registry.candoris.com/candoris/cci-resource-type
docker push registry.candoris.com/candoris/cci-resource-type
```

Use this resource type:

In `pipeline.yml`:

```
resource_types:
  - name: cci-resource-type
    type: docker-image
    source:
      repository: registry.candoris.com/candoris/cci-resource-type
      username: ((concourse-registry.username))
      password: ((concourse-registry.password))

resources:
  - name: <repo>-git
    type: git
    source:
      uri: git@github.com:Candoris/<repo>.git
      branch: <branch>
      private_key: |
        ((concourse-github.privateKey))

  - name: cci
    type: cci-resource-type
    source:
      cumulusci_key: ((concourse-cci.key))

jobs:
  - name: deploy
    serial: true
    plan:
      - get: <repo>-git
        trigger: false
      - put: cci
        params:
          project_dir: <repo>-git
          org_dir: <repo>-git/cci-orgs
          project_name: <project name>
          command: task
          args: run dx_deploy --org <org name>

```

`<org name>` is the name of the org file that you will have create locally:

```
cci org connect <org name> [--sandbox]
cp ~/.cumulusci/<project name>/<org name>.org <local org dir in repo>
```
