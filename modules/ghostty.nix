{ ... }:

{
  xdg.configFile."ghostty/config".text = ''
    window-padding-balance = true
    window-theme = ghostty
    background-opacity = 0.85
    background-blur-radius = 20
    font-size = 8
    font-thicken = true
    async-backend = epoll
    # dlig (合字) を無効にしないと「ます」が「〼」で表示される。
    font-feature = -dlig
    auto-update-channel = tip
    theme = Ayu Mirage
    keybind = shift+enter=text:\n
    keybind = performable:ctrl+v=paste_from_clipboard
    keybind = ctrl+shift+f=unbind
  '';
}
