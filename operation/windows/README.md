# Windows Operation Playbooks

- Clean Up `Windows Update` intermediate files
- Evacuate `Windows Module Installer Service` temporary files 
- Re-sync time  ( * beta, needs execute repeatedly .. )


# Execute Sample

```
env ANSIBLE_CONFIG=/opt/ansible_win/ansible.cfg ansible-playbook ./cleanup-win-update-tmp-files.yml -l windows-host  -vvv
```


# Inventory File Sample

```
[windows]
192.168.33.99

[windows:vars]
ansible_ssh_user=Administrator
ansible_ssh_pass=*************
ansible_ssh_port=5985      # ← http。https は 5986
ansible_connection=winrm
```


# refs 

- https://speakerdeck.com/sogaoh/ansible-playbook-cleanup-winupd-tempfiles
- http://blog.serverworks.co.jp/tech/2016/02/23/ansible20-windows/
- http://www.torutk.com/projects/swe/wiki/Ansible#Ansible制御マシン側の設定
- https://docs.microsoft.com/ja-jp/powershell/wmf/5.0/install
- https://blogs.technet.microsoft.com/askcorejp/2015/04/15/cwindowstemp-cab_xxx_x-x-37327/
