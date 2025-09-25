encrypt:
	ansible-vault encrypt terraform/secret.auto.tfvars terraform/secret.backend.tfvars ansible/inventory.ini ansible/group_vars/webservers/secrets.yml --vault-password-file .vault-password

decrypt:
	ansible-vault decrypt terraform/secret.auto.tfvars terraform/secret.backend.tfvars ansible/inventory.ini ansible/group_vars/webservers/secrets.yml --vault-password-file .vault-password

TERRAFORM_CMDS = init i-migrate i-upgrade plan apply destroy show graph

define TF_TARGET
t-$(1):
	make -C terraform $(1)
endef

$(foreach cmd,$(TERRAFORM_CMDS),$(eval $(call TF_TARGET,$(cmd))))

ANSIBLE_CMDS = install-deps deploy prepare redmine datadog

define ANS_TARGET
a-$(1):
	make -C ansible $(1)
endef

$(foreach cmd,$(ANSIBLE_CMDS),$(eval $(call ANS_TARGET,$(cmd))))
