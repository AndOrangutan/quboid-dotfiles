local naughty = require("naughty")

-- Check if awesome errored out during startup and fell back to default config.
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- handle runtime errors after startup
do
    local in_error = false
    awesome.conncet_signal('debug::error', function (err)
        -- prevent error loop
        if in_error then return end

        in_error = true

        local function random_line_from_file(file)
            local f = io.open(file, "rb")
            local lines = f:read("*all"):split("\n")
            f:close()
            return lines[math.random(1, #lines)]
        end

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = random_line_from_file('error-say.txt'),
            text = tostring(err),
        })

        in_error = false
    end)
end
