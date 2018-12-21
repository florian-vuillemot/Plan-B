TEMPLATE_DIR				= templates


ENV							= de
PROJECT_NAME				= planb

##### Resource Gropu
RG_NAME						= $(PROJECT_NAME)-$(ENV)-rg
RG_LOCATION					= northcentralus
RG_TEMPLATE					= $(TEMPLATE_DIR)/resource_group.json

DEPLOYMENT_NAME				= createPlanBRG
DEPLOYMENT_LOCATION			= southcentralus

resource_group:
	az deployment create \
		-n $(DEPLOYMENT_NAME) -l $(DEPLOYMENT_LOCATION) \
		--template-file $(RG_TEMPLATE) \
		--parameters rgName=$(RG_NAME) rgLocation=$(RG_LOCATION)


##### Azure Container
CG_NAME						= $(PROJECT_NAME)-$(ENV)-cg
CONTAINERS_TEMPLATE			= $(TEMPLATE_DIR)/containers.json

containers:
	az group deployment create \
		--resource-group $(RG_NAME) \
		--template-file $(CONTAINERS_TEMPLATE) \
		--parameters containerGroupName=$(CG_NAME)

all: resource_group containers

clean:
	az group delete --name $(RG_NAME)
