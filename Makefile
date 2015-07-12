SITE_NAME ?= SiteTemplate

all:
	rake db:create db:migrate db:seed
	sed -i -- 's/SiteTemplate/$(SITE_NAME)/g' *config/application.rb*
