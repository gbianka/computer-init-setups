sudo apt-get update
# Nice PS1
echo -e 'export PS1="\W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "' >> ~/.bashrc
####### OBS: Ao rodar o comando acima, deu erro de Permission denied.   [PARECE QUE A TRETA TODA É PQ EU NÃO DEI UM 'sudo su' ANTES PARA FICAR COM USER 'root']
####### Para funcionar, com base em https://techoverflow.net/2019/03/16/how-to-solve-permission-denied-error-when-trying-to-echo-into-a-file/, fiz o seguinte: 
####### echo -e 'export PS1="\W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "' | sudo tee -a ~/.bashrc

# Install dev stuff
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm gettext libncurses5-dev tk-dev tcl-dev blt-dev libgdbm-dev git python-dev python3-dev aria2 vim libnss3-tools python3-venv liblzma-dev libpq-dev keychain

# XLaunch configuration:
## Install on windows: https://sourceforge.net/projects/vcxsrv/
## During initialization you need check "Disable Access Control" every time, or it will not work
echo -e 'export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0' >> ~/.bashrc
####### OBS: Ao rodar o comando acima, deu erro de Permission denied.  [PARECE QUE A TRETA TODA É PQ EU NÃO DEI UM 'sudo su' ANTES PARA FICAR COM USER 'root']
####### Para funcionar, fiz o seguinte [detalhe também que precisei trocar aspas simples para aspas duplas deppois de awk porque dava erro: 
####### echo -e 'export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk "{print $4}"):0.0' | sudo tee -a ~/.bashrc


####### OBS: Para conseguir rodar os comandos abaixo, precisei, antes, rodar o 'sudo su'

#Pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo -e 'export PATH="~/.pyenv/bin:$PATH"' >> ~/.bashrc
echo -e 'eval "$(pyenv init --path)"\n' >> ~/.bashrc
echo -e 'eval "$(pyenv virtualenv-init -)"\n' >> ~/.bashrc

# Pycharm
mkdir ~/bin
wget https://download.jetbrains.com/python/pycharm-professional-2021.2.2.tar.gz -O ~/bin/pycharm-professional-2021.2.2.tar.gz ### OBS: Mudei apenas para 2020.2.2, que é a que tenho licença
tar -xf ~/bin/pycharm-professional-2021.2.2.tar.gz --directory ~/bin ### OBS: Mudei apenas para 2020.2.2, que é a que tenho licença
rm ~/bin/pycharm-professional-2021.2.2.tar.gz ### OBS: Mudei apenas para 2020.2.2, que é a que tenho licença
touch ~/.bash_aliases
echo -e 'alias charm="bash ~/bin/pycharm-2021.2.2/bin/pycharm.sh > /dev/null 2>&1 &"' >> ~/.bash_aliases ### OBS: Mudei apenas para 2020.2.2, que é a que tenho licença


sudo apt remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose
sudo usermod -aG docker $USER

# Nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
nvm install 14

# Vue cli
npm install -g vue-cli

# SSH: https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54
ssh-keygen -o -a 100 -t ed25519

# SSH Keychain: https://esc.sh/blog/ssh-agent-windows10-wsl2/

echo -e '/usr/bin/keychain -q --nogui $HOME/.ssh/id_ed25519' >> ~/.bashrc
echo -e 'source $HOME/.keychain/$HOST-sh\n' >> ~/.bashrc
