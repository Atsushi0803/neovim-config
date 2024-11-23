vim.o.number = true
vim.o.ts = 4
vim.o.expandtab=true
vim.o.shiftwidth=4
vim.g.node_host_prog = "~/.local/share/nvm/v22.11.0/bin/node"
vim.g.npm_host_prog = "~/.local/share/nvm/v22.11.0/bin/npm"
vim.g.NODE_PATH = "~/.local/share/nvm/v22.11.0/bin/node"
vim.g.NPM_PATH = "~/.local/share/nvm/v22.11.0/bin/npm"
vim.g.python3_host_prog = "~/.config/nvim/.venv-neovim/bin/python3"
vim.g.pip_host_prog = "~/.config/nvim/.venv-neovim/bin/pip3"
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

