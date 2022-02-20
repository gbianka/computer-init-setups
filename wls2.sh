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
### [OBS: Se estiver usando Windows/WSL, que é o meu caso, deve ser baixado no link acima e instalado no computador
### Depois que instala, para acessar, basta ir no Pesquisar do computador e digitar XLaunch. Vai abrir uma janela e vc faz o seguinte:
### Next > Next. Em 'extra settings', marca todas as opções. A última não vem marcada por padrão, mas é preciso marcar e Avançar.

## During initialization you need check "Disable Access Control" every time, or it will not work
echo -e 'export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0' >> ~/.bashrc
####### OBS: Ao rodar o comando acima, deu erro de Permission denied.  [PARECE QUE A TRETA TODA É PQ EU NÃO DEI UM 'sudo su' ANTES PARA FICAR COM USER 'root']
####### Para funcionar, fiz o seguinte [detalhe também que precisei trocar aspas simples para aspas duplas deppois de awk porque dava erro: 
####### echo -e 'export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk "{print $4}"):0.0' | sudo tee -a ~/.bashrc


####### OBS: Para conseguir rodar os comandos abaixo, precisei, antes, rodar o 'sudo su'

# Pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo -e 'export PATH="~/.pyenv/bin:$PATH"' >> ~/.bashrc
echo -e 'eval "$(pyenv init --path)"\n' >> ~/.bashrc
echo -e 'eval "$(pyenv virtualenv-init -)"\n' >> ~/.bashrc
### Instalando um python pelo pyenv que acabou de ser instalado
### Para ver quais versões de python tem instaladas, rodar o comando pyenv versions. Ao fazer isso pela primeira vez, ele vai mostrar provavelmente
### só a system, que é a versão que o sistema está usado (grandes chances de ser a python 2.7). Para conferir, rode python -V
### É ALTAMENTE RECOMENDADO instalar uma versão de python para vc trabalhar (não é interessante a última), portanto, vamos instalar a 3.9.7: pyenv install 3.9.7
### Feito isso, vamos novamente rodar python versions para checar se instalou direitinho. Com esse comando também é possível verificar
### qual versão o pyenv está usando (é a que tem asterisco).
### DEVE SER DEFINIDA COMO GLOBAL a que você acabou de instalar, senão o pyenv usa a padrão do sistema(2.7) aí dá ruim.
### Para definir a versão que deve ser considerada pelo pyenv, executar pyenv global 3.9.7.
### Feito isso, só para garantir, rode pyenv versions (o * deve estar na 3.9.7) e python -V (que deve mostrar Python 3.9.7)
### [opcional] Para ver o diretório onde o python está instalado, digitar pyenv which python


# Pycharm
mkdir ~/bin
wget https://download.jetbrains.com/python/pycharm-professional-2021.2.2.tar.gz -O ~/bin/pycharm-professional-2021.2.2.tar.gz ### OBS: Mudei apenas para 2020.2.2, que é a que tenho licença
tar -xf ~/bin/pycharm-professional-2021.2.2.tar.gz --directory ~/bin ### OBS: Mudei apenas para 2020.2.2, que é a que tenho licença
rm ~/bin/pycharm-professional-2021.2.2.tar.gz ### OBS: Mudei apenas para 2020.2.2, que é a que tenho licença
touch ~/.bash_aliases
echo -e 'alias charm="bash ~/bin/pycharm-2021.2.2/bin/pycharm.sh > /dev/null 2>&1 &"' >> ~/.bash_aliases ### OBS: Mudei apenas para 2020.2.2, que é a que tenho licença
### OBS: Feito isso, no terminal digita charm e é para abrir o pycharm instalado no linux (o meu não abriu..rs...vou testar depois que reiniciar o computador)


sudo apt remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose
sudo usermod -aG docker $USER
### Depois de executar os comandos acima, é OBRIGATÓRIO reiniciar o computador


# Nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
nvm install 14

# Vue cli
npm install -g vue-cli

# SSH: https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54
ssh-keygen -o -a 100 -t ed25519
### No meu apareceu isso "Enter file in which to save the key (/root/.ssh/id_ed25519):". Aí eu só dei ENTER
### Em seguida, pediu um passfrase, eu digitei minha passfrase ver no meu computador _PESSOAL lá por dentro tem um arquivo que vai ter o que coloquei
### FALTA: Levar a CHAVE PÚBLICA LÁ PARA O GITHUB/BITBUCKET

# SSH Keychain: https://esc.sh/blog/ssh-agent-windows10-wsl2/

echo -e '/usr/bin/keychain -q --nogui $HOME/.ssh/id_ed25519' >> ~/.bashrc
echo -e 'source $HOME/.keychain/$HOST-sh\n' >> ~/.bashrc
