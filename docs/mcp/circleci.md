# CircleCI MCP

* **Description**: Enable AI Agents to fix build failures from CircleCI.
* **Repository**: Celebrum/servers
* **Configuration**:
  - Add to `Subrepos` list in `modulesettings.json`:
    ```json
    "Subrepos": [
      "servers",
      "containerz-plugin",
      "models-prefab",
      "tensorzero",
      "circleci"
    ]
    ```
