asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add rebar https://github.com/Stratus3D/asdf-rebar.git

asdf install erlang 27.0
asdf install rebar 3.24

asdf global erlang 27.0
asdf global rebar 3.24

git clone https://github.com/erlang-ls/erlang_ls --depth 1
cd erlang_ls
make
PREFIX=~/.bin/ make install

rm -rf erlang_ls
