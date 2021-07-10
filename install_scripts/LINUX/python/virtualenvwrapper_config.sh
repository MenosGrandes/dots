python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install --user virtualenvwrapper

cp .virtualenvwrapper.conf ~/.config/

#echo $(python3 -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])') >> ~/.bashrc
echo 'export PATH="$PATH:/home/mg/.local/bin" ' >> ~/.bashrc
echo 'source ~/.config/.virtualenvwrapper.conf' >> ~/.bashrc
