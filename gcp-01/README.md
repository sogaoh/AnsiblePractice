# gcp-01 

## What's this ?
- Zabbix Advent Calendar # Day 24 の環境構築のために作成したコード
- 要素は以下の通り
    - srv-01
        - Zabbix Server
            - 先行して PostgreSQL のインストールが必要
    - agt-01
        - Zabbix Agent


## 実行時環境情報
- macOS Mojave 10.14.1
- VSCode 1.30.1
- ansible 2.7.1
    - python version = 3.7.0 (default, Oct  2 2018, 09:18:58) [Clang 10.0.0 (clang-1000.11.45.2)]


## Prerequirements 
- 適用先の CentOS 7 サーバー２台
    - see : [sogaoh/TerraformPractice/gcp-01](https://github.com/sogaoh/TerraformPractice/tree/master/gcp-01)
- Ansible のインストール


## 利用方法
- Set `inventory`
    ```
    [localhost]
    127.0.0.1 ansible_connection=local

    [nodes]
    srv-01 ansible_host=[srv-01 IP Address]
    agt-01 ansible_host=[agt-01 IP Address]

    [nodes:vars]
    ansible_ssh_user=[your_user]
    ansible_ssh_private_key_file=[/path/to/your_private_key]
    ansible_become=yes
    ansible_become_user=root
    ansible_become_method=enable
    ```

- Execute commands 
    ```
    cd ${your_appropriate_directory}
    git clone https://github.com/sogaoh/AnsiblePractice.git

    cd AnsiblePractice/gcp-01
    mkdir roles
    cd roles

    ansible-galaxy install geerlingguy.postgresql
    ansible-galaxy install dj-wasabi.zabbix-web
    ansible-galaxy install dj-wasabi.zabbix-server
    ansible-galaxy install dj-wasabi.zabbix-agent

    mv ${/path/to/.ansible}/roles/* ./ 

    cd ..      # ${your_appropriate_directory}/AnsiblePractice/gcp-01

    sed -i -e "s/peer/trust/g" roles/geerlingguy.postgresql/defaults/main.yml     # "-e" is for Mac OSX

    ansible-playbook ./00_initial-adjust.yaml -i "[srv-01 IP Address],"
    ansible-playbook ./01_postgresql-server.yaml -i "[srv-01 IP Address],"
    ansible-playbook ./02_zabbix-single-server.yaml -i "[srv-01 IP Address],"

    ansible-playbook ./00_initial-adjust.yaml -i "[agt-01 IP Address],"
    ansible-playbook ./03_zabbix-agent.yaml -i "[agt-01 IP Address],"
    ```
    Check http://[srv-01 Global IP Address] 


## 構築メモ
- /etc/zabbix/zabbix_agentd.conf への以下指定は意図通りにできていない
    - Hostname
    - ListenIP
- `srv-01` 自身の監視疎通が、このPlaybook群実行後も成立できていない。以下のエラーになっているが、追跡を断念（2018/12/26）
    - Web UI
        - `Received empty response from Zabbix Agent at [127.0.0.1]. Assuming that agent dropped connection because of access permissions.`
    - zabbix_agentd.log
        ```
        no active checks on server [srv-01:10051]: host [(srv-01 Global IP Address)] not found
        failed to accept an incoming connection: connection from "127.0.0.1" rejected, allowed hosts: "srv-01
        ```