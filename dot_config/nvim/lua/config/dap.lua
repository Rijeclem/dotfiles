local dap = require("dap")

-- Adapter using lldb (Mason will handle installation)
dap.adapters.cppdbg = {
    type = "executable",
    command = "lldb-vscode", -- Mason installs this automatically
    name = "cppdbg",
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolderolder}",
        stopOnEntry = true,
    },
}

dap.adapters.cppdbg = {
    type = "executable",
    command = "/usr/bin/rust-lldb", -- replace with correct path if different
    name = "cppdbg",
}

dap.configurations.c = dap.configurations.cpp
