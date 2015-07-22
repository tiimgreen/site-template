SITE_NAME ?= SiteTemplate
DASH_SITE_NAME ?= site-template
UPPER_DASH_SITE_NAME = $(shell echo $(DASH_SITE_NAME) | tr a-z A-Z)

all:
	sed -i -- 's/SiteTemplate/$(SITE_NAME)/g' *config/application.rb*
	sed -i -- 's/site-template/$(DASH_SITE_NAME)/g' *config/initializers/session_store.rb*
	sed -i -- 's/site-template/$(DASH_SITE_NAME)/g' *config/database.yml*
	sed -i -- 's/SITE-TEMPLATE/$(UPPER_DASH_SITE_NAME)/g' *config/database.yml*
	rake db:create db:migrate db:seed
	rspec
