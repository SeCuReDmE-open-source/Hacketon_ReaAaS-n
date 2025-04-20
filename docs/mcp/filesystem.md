# Filesystem MCP

## Description
Secure file operations with configurable access controls.

## Repository
Celebrum/servers

## Configuration
To include the Filesystem MCP in your `modulesettings.json`, add it to the `Subrepos` list under the `MCPServer` section:

```json
"MCPServer": {
    "Enabled": true,
    "Host": "localhost",
    "Port": 5000,
    "APIKey": "your-api-key",
    "Subrepos": [
      "servers",
      "containerz-plugin",
      "models-prefab",
      "tensorzero",
      "filesystem"
    ]
}
```
