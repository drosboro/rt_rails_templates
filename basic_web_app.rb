#
# Rosborough Tech App Template
# 
# Created at: 2011-03-26
# Author: Dave Rosborough
#
# This provides a basic web-app template for my own private use.  It includes a bunch of my normal gems.
# 
# Copyright © 2011 Rosborough Technology Co.
# 
# This file is part of RT Rails Templates.
# 
# RT Rails Templates is free software: you can redistribute it and/or modify it under the terms of the 
# GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of 
# the License, or (at your option) any later version.
# 
# RT Rails Templates is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
# Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License along with Foobar. If not, 
# see http://www.gnu.org/licenses/.

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