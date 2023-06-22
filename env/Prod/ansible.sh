#!/bin/bash/

#############################################################################################
# Autor: Thais Rocha
# Descrição: Script para instalar o pip e o ansible, depois cria e executa o playbook do ansible.
#############################################################################################

# Validando o path
cd /home/ubuntu
# Fazendo o Download do pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.sh
# Rodar o script do pip
sudo python3 get-pip.sh
# Instalar o pip por python3
sudo python3 -m pip install ansible
# Criação do playbook 
tee -a playbook.yml > /dev/null <<EOT
- hosts: localhost
  tasks:
  - name: Instalando o python3, virtualenv
    apt:                                       # apt install
      pkg:                                     # Pacotes
      - python3
      - virtualenv
      update_cache: yes                        # Atualizar apt update(Repositorios), apt upgrade (Dos pacotes).
    become: yes                                # Executar como root

  - name: Git clone
    ansible.builtin.git:
      repo: https://github.com/alura-cursos/clientes-leo-api.git
      dest: /home/ubuntu/tcc
      version: master
      force: yes
  - name: Instalando dependências com pip
    pip:
      virtualenv: /home/ubuntu/tcc/venv
      requirements: /home/ubuntu/tcc/requirements.txt

  - name: Alterando o hosts do settings
    lineinfile:
      path: /home/ubuntu/tcc/setup/settings.py
      regexp: 'ALLOWED_HOSTS'
      line: 'ALLOWED_HOSTS = ["*"]'
      backrefs: yes
  - name: configurando o banco de dados
    shell: '. /home/ubuntu/tcc/venv/bin/activate; python /home/ubuntu/tcc/manage.py migrate'
  - name: carregando os dados iniciais
    shell: '. /home/ubuntu/tcc/venv/bin/activate; python /home/ubuntu/tcc/manage.py loaddata clientes.json'
  - name: Iniciando o servidor
    shell: '. /home/ubuntu/tcc/venv/bin/activate; nohup python /home/ubuntu/tcc/manage.py runserver 0.0.0.0:8000 &'
EOT

# Executar o playbook
ansible-playbook playbook.yml
