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
    awesome.connect_signal('debug::error', function (err)
        -- prevent error loop
        if in_error then return end

        in_error = true


        naughty.notify({
            preset = naughty.config.presets.critical,
            title = 'Whoops something whent wrong!',
            text = tostring(err),
        })

        in_error = false
    end)
end
