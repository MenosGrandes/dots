python3 -m pip install --update pip setuptools wheel
python3 -m pip install --user virtualenvwrapper

cp .virtualenvwrapper.conf ~/.config/
echo -e 'source ~/.config/.virtualenvwrapper.conf' >> ~/.bashrc
