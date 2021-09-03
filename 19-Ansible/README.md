```
1427  cd 19-Ansible/
 1428  ls
 1429  vim inventory
 1430  ls
 1431  apt-get install ansible -y
 1432  ansible version
 1433  ansible -version
 1434  ansible --version
 1435  cat /etc/ansible/ansible.cfg
 1436  ls
 1437  ansible all -i inventory -m ping -u vagrant -k
 1438  apt-get install sshpass
 1439  ansible all -i inventory -m ping -u vagrant -k
 1440  ansible-doc  -l
 1441  ansible-doc apt
 1442  ansible all -i inventory -m ping -u vagrant -k
 1443  ansible 172.31.0.100 -i inventory -m ping -u vagrant -k
 1444  vim inventory
 1445  ansible all -i inventory -m ping -u vagrant -k
 1446  ansible web -i inventory -m ping -u vagrant -k
 1447  ansible db -i inventory -m ping -u vagrant -k
 1448  systemctl status apache2
 1449  ansible db -i inventory -u vagrant -m service -a "name=apache2 state=stopped" -k
 1450  ansible web -i inventory -u vagrant -m service -a "name=apache2 state=stopped" -k
 1451  ansible web -i inventory -u vagrant -m service -a "name=apache2 state=stopped" -k  -s
 1452  systemctl status apache2
 1453  ansible web -i inventory -u vagrant -m service -a "name=apache2 state=stopped" -k  -s
 1454  ansible web -i inventory -u vagrant -m service -a "name=apache2 state=started" -k  -s
 1455  systemctl status apache2
 1456  ls
 1457  vim playbook.yaml
 1458  ls
 1459  systemctl status apache2
 1460  ansible-playbook -i inventory playbook.yaml -u vagrant -k
 1461  systemctl status apache2
 1462  ansible-playbook -i inventory playbook.yaml -u vagrant -k
 1463  systemctl status apache2
 1464  systemctl start apache2
 1465  systemctl status apache2
 1466  ansible-playbook -i inventory playbook.yaml -u vagrant -k
 1467  ls
 1468  ansible web -i inventory -u vagrant -m setup -k  -s
 1469  ls
 1470  vim playbook.yaml
 1471  ls
 1472  mkdir templates
 1473  echo "Hey Ansible" > templates/index.html
 1474  ls
 1475  ansible-playbook -i inventory playbook.yaml -u vagrant -k
 1476  vim templates/index.html
 1477  ansible-playbook -i inventory playbook.yaml -u vagrant -k
 1478  ls
 1479  history
```
