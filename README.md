# check_sap_availability

```
-> Importe este script para /srv/zabbix/scripts.
Caso não exista crie o caminho.
"mkdir -p /srv/zabbix/scripts"
"check_sap_availability.sh"

-> Importe este arquivo para /etc/zabbix/zabbix_agentd.d
"sap_availability.conf"

-> Importe este template no seu servidor Zabbix.
"Template SAP Availability Linux.xml"

-> Adicione o usuário zabbix no grupo com permissão para executar o comando saphostctrl
"gpasswd -a zabbix sapsys"

-> Script via linha de comando.
check_sap_availability.sh hdbnameserver 00
