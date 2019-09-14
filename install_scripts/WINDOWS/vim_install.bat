choco install neovim -y
COPY ..\..\vim\init.vim %localappdata%\nvim
nvim-qt +PlugUpdate
