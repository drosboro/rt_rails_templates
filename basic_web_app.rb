#
# Rosborough Tech App Template
# 
# Created at: 2011-03-26
# Author: Dave Rosborough
#
# This provides a basic web-app template for my own private use.  It includes a bunch of my normal gems.
# 

gem "jquery-rails"
gem "haml"
gem "less"
gem "will_paginate", ">= 3.0.pre2"
gem "capistrano"
gem "web-app-theme, ">= 0.6.2", :group => [:development, :test]
gem "devise"
gem "cancan"
gem "formtastic"

run "bundle install"
rake "db:create"

generate 'jquery:install --ui'

generate "devise:install"
generate "devise User"
generate "devise:views -t=haml"
generate "cancan:ability"

rake "db:migrate"

theme = ask("Enter the name of the web-app-theme you'd like to use: [warehouse]")
theme = warehouse if theme == ""

generate "web-app-theme:theme --theme=#{theme} --engine=haml"

remove_file 'public/index.html'
remove_file 'rm public/images/rails.png'
run 'cp config/database.yml config/database.example'
run "echo 'config/database.yml' >> .gitignore"

# commit to git
git :init
git :add => "."
git :commit => "-a -m 'create initial application'"