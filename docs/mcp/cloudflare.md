### Cloudflare

* **Description**: Deploy, configure & interrogate your resources on the Cloudflare developer platform (e.g. Workers/KV/R2/D1).
* **Repository**: Celebrum/servers
* **Configuration**:
  - Add to `Subrepos` list in `modulesettings.json`:
    ```json
    "Subrepos": [
      "servers",
      "containerz-plugin",
      "models-prefab",
      "tensorzero",
      "cloudflare"
    ]
    ```
