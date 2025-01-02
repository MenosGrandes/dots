git clone https://github.com/erlang-ls/erlang_ls --depth 1
cd erlang_ls
make
PREFIX=~/ make install

rm -rf erlang_ls
