'Windows Update' Cleaning Script, and others

# Execute Sample

```
env ANSIBLE_CONFIG=/opt/ansible_win/ansible.cfg ansible-playbook ./cleanup-win-update-tmp-files.yml    -l windows  -vvv
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

https://blogs.technet.microsoft.com/askcorejp/2015/04/15/cwindowstemp-cab_xxx_x-x-37327/
