vim.o.number = true
vim.o.ts = 4
vim.o.expandtab=true
vim.o.shiftwidth=4
vim.g.node_host_prog = "/home/atsushi-n/.nvm/versions/node/v22.11.0/bin/node"
vim.g.python3_host_prog = "/home/atsushi-n/.config/nvim/.venv-neovim/bin/python3"
vim.env.PATH = vim.env.PATH .. ":/home/atsushi-n/.config/nvim/.venv-neovim/bin"
vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
    },
    paste = {
        ["+"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('`r', ''))",
        ["*"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('`r', ''))",
    },
    cache_enabled = 0,
}

