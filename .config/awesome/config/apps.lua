local _M = {
   terminal = os.getenv('TERMINAL') or 'wezterm',
   editor   = os.getenv('EDITOR') or 'vim',
}

_M.menu_apps = {
   -- TODO: Add browser, image editor, vscode, etc
   { 'Terminal', _M.terminal },
   { 'Editor', _M.editor },
}
_M.editor_cmd = _M.terminal .. ' -e ' .. _M.editor
_M.manual_cmd = _M.terminal .. ' -e man awesome'

return _M
