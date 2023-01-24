.PHONY:

doc:
	echo "See Makefile"

ping:
	# NOTE: inventory.ini is generated by 02_terraform/
	ansible -i inventory.ini all -m ping

install:
	ansible-galaxy install -r requirements.yml

play:
	ansible-playbook -i inventory.ini playbook.yml