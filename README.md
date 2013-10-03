About
=====

This repository contains Ansible roles that assist with deploying Node.js applications such as the [GPII Preferences Server](https://github.com/GPII/universal/tree/master/gpii/node_modules/preferencesServer) along with CouchDB, Nginx, and Tsung. The roles have been tested on CentOS 6.4 and were used to carry out distributed load tests on the Preferences Server in various deployment scenarios.

Repository Contents
===================

* group_vars - Variables utilized by groups of hosts
* playbooks - Scripts, Tsung configuration files, and a playbook that primes a CouchDB database and manages test runs
* roles - [Ansible roles](http://www.ansibleworks.com/docs/playbooks.html#roles) for deploying various services
* scenario_* - Inventory files used for each test scenario
* site.yml - Main playbook

Getting Started
===============

1. If you would like to run your own load tests you will need to [install Ansible](http://www.ansibleworks.com/docs/gettingstarted.html), preferably on a host that has [OpenSSH 5.6 or a more recent SSH client](http://www.ansibleworks.com/docs/gettingstarted.html#choosing-between-paramiko-and-native-ssh).

2. Edit any of the scenario files to include the names or IP addresses of your own hosts. However do not change the group names since those are used by the roles.

3. Make sure that you have SSH key based authentication configured to grant access to your Ansible control host.

4. Provision your hosts with the necessary services: `ansible-playbook site.yml -i scenario_1`

5. Prime CouchDB with [test preferences](https://github.com/GPII/universal/tree/master/testData/preferences) and start a load test `ansible-playbook playbooks/run_test.yml -i scenario_1` This will run for about thirty minutes and Ansible will poll the test process every minute. Once the test is complete a report will be generated and viewable at http://<your_tsung_controller_host/reports/

6. You can reboot all your hosts in between multiple test runs using this command `ansible all -i scenario_1 -m shell -a 'sudo reboot'`

