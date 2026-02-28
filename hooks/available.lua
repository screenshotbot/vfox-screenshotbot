--- Returns a list of available versions for the tool
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#available-hook
--- @param ctx {args: string[]} Context (args = user arguments)
--- @return table[] List of available versions
function PLUGIN:Available(ctx)
    local http = require("http")
    local json = require("json")

    local repo_url = "https://screenshotbot.io/screenshotbot-cli-versions"

    local resp, err = http.get({
        url = repo_url,
    })

    if err ~= nil then
        error("Failed to fetch versions: " .. err)
    end

    if resp.status_code ~= 200 then
        error("GitHub API returned status " .. resp.status_code .. ": " .. resp.body)
    end

    local versions = json.decode(resp.body)
    local result = {}

    -- Process tags/releases
    for _, version in ipairs(versions) do
        table.insert(result, {
            version = version,
        })
    end

    return result
end
