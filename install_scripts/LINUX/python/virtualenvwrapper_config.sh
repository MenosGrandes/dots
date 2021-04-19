sudo apt-get install virtualenv --upgrade
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install --user virtualenvwrapper

cp .virtualenvwrapper.conf ~/.config/
echo 'export PATH="$PATH:/home/mg/.local/lib/python3.6/site-packages' >> ~/.bashrc
echo 'export PATH="$PATH:/home/mg/.local/bin' >> ~/.bashrc
echo 'source ~/.config/.virtualenvwrapper.conf' >> ~/.bashrc
