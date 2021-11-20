sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update -qq
sudo apt install golang-go -qq -a
go install github.com/mattn/efm-langserver@latest
