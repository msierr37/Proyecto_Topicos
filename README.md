# Proyecto_topicos

Proyecto de la materia Tópicos Telemática by Jose David Sanchez Castrillon - jsanch81@eafit.edu.co

## 1. Creating the Article Application

rails new Articles

## 2. Starting up the WebApp Server

rails server

Open browser: http://localhost:3000
## 3. Main page: "Hello World"

rails generate controller Welcome index

edit: app/views/welcome/index.html.erb config/routes.rb

## 4. Editing routes

=begin get "/articles" index post "/articles" create delete "/articles/:id" destroy get "/articles/:id" show get "/articles/new" new get "/articles/:id/edit" edit patch "/articles/:id" update put "/articles/:id" update =end

## 5. Generate controller for Articles

rails generate controller Articles

## 6. Create a FORM HTML for new articles

app/views/articles/new.html.erb:

<div style="width:100%;margin:1; auto; align-text:center;">
  <h1 class="crear">Agregar canción</h1>
  <%=render "form"%>
</div>
app/views/articles/_form.html.erb:

<%= form_for(@article) do |f| %>
  <% @article.errors.full_messages.each do |message|%>
    <div class="be-red white err">
      *<%=message%>
    </div>
  <%end%>
  <div class="field">

    <h5 class="inicio">Privacidad de la canción: </h5>-<%= f.select :privacida, options_for_select([["Publico"], ["Privado"],["Compartido"]]) %>
  </div>
  <div class="field">
    <%= f.text_field :title, placeholder: "Titulo de la canción", class:"form-control" %>
  </div>
  <div class="field">
    <%= f.text_field :artista, placeholder: "Nombre del artista", class:"form-control" %>
  </div>
  <div class="field">
    <%= f.text_field :tamano, placeholder: "Tamaño de la canción en Megabytes", class:"form-control" %>
  </div>
  <div class="field">
    <%= f.text_field :album, placeholder: "Nombre del album", class:"form-control" %>
  </div>
  <div class="field">
    <%= f.text_field :ano, placeholder: "Año de estreno", class:"form-control" %>
  </div>
  <div class="field">
    <%= f.text_field :tiempo, placeholder: "Duración de la canción", class:"form-control" %>
  </div>
  <div class="field">
    <%= f.text_area :body, placeholder: "Descripcion de la canción", style:"height:200px", class:"form-control" %>
  </div>
  <div class="field inicio">
    <%=f.label :mp3 %><br>
    <%=f.file_field :mp3%>
  </div>
  <div class="field">
      <%=f.submit "Guardar", class:"btn"%>
  </div>
<%end %>

## 7. Creating the Article model

rails generate model Article title:string body:string artista:string tamano:string privacida:string album:string ano:integer tiempo:string

class CreateArticles < ActiveRecord::Migration[5.1] def change create_table :articles do |t| t.string :title t.text :body t.integer :visits_count t.string :disponible t.string :tamano end end end

## 8. Running a migration

rails db:migrate

include postgresql in test and production environment:

test: database: db_musica adapter: postgresql pool: 5 username: jsanch81 password: 9708 host: localhost port: 5432

production: database: db_musica adapter: postgresql pool: 5 username: jsanch81 password: 9708 host: localhost port: 5432

## 9. Saving data in the controller

#POST /articles
def create
  @article = current_user.articles.new(article_params)
  if @article.save
    redirect_to @article
  else
    render :new
  end
end

## 10. Showing articles

#GET /articles/:id
def show
  @article.update_visits_count
end

app/views/articles/show.html.erb
<%= @article.title %>

#GET article
def index
  palabra = "%#{params[:keyword]}%"
  if palabra!=nil
    @articles = Article.where("title LIKE ? OR artista LIKE ? OR album LIKE ?",palabra,palabra,palabra)
  else
    @articles = Article.all.recientes
  end
end

#GET /articles/new
def new
  @article = Article.new
end

app/views/articles/index.html.erb
<div class="center-xs field",id="bus">
  <%= form_tag articles_path, method: :get do %>
    <%= text_field_tag :keyword,nil,placeholder: "¿Que estas buscando?" %>
    <%= content_tag :button,class:"btn", type: :submit do%>
      Buscar
    <% end %>
  <% end %>
</div>

    <div id="my-div3">
      <% @articles.reverse.each do |article| %>
      <div id="jquery_jplayer_<%=article.id%>" class="cp-jplayer center-xs"></div>
        <% if article.privacida == "Publico" %>
          <div class="center-xs col-md inicio">
              <h1 class="inicio"><%=link_to article.title, article%></h1>
              <h5 class="inicio">Artista: <%=article.artista%></h5>
              <div>
                <%=article.body%>
                <% if user_signed_in? and article.user== current_user %>
                  <div class="ini"><%= link_to "Eliminar", article, method: :delete, class:"red"%></a></div>
                <% end %>
              </div>
            </div>
        <% end %>
        <% if  article.privacida == "Privado" and article.user == current_user %>
            <div class="center-xs col-md inicio">
              <h1 class="inicio"><%=link_to article.title, article%></h1>
              <h5 class="inicio">Artista: <%=article.artista%></h5>
              <div>
                <%=article.body%>
                <% if not article.user == nil %>
                  <p class="inicio center-xs">subido por: <%=article.user.email%></p>
                  <% else %>
                  <p>subido por: Cuenta cerrada</p>
                    <% end %>
                  <% if article.user== current_user %>
                    <div class="ini"><%= link_to "Eliminar", article, method: :delete, class:"red"%></a></div>
                  <% end %>
                </div>
              </div>
        <% end %>
        <% if article.privacida == "Compartido" and user_signed_in? %>
              <div class="center-xs col-md inicio">
                <h1 class="inicio"><%=link_to article.title, article%></h1>
                <h5 class="inicio">Artista: <%=article.artista%></h5>
                <div>
                  <%=article.body%>
                  <% if not article.user == nil %>
                    <p class="inicio center-xs">subido por: <%=article.user.email%></p>
                  <% else %>
                    <p>subido por: Cuenta cerrada</p>
                  <% end %>
                    <p class="inicio center-xs">visitas: <%=article.visit_count%></p>
                  <% if article.user == current_user %>
                    <div class="ini"><%= link_to "Eliminar", article, method: :delete, class:"red"%></a></div>
                  <% end %>
                </div>
              </div>
            <% end %>

          <%end%>
      </div>

## 12. Updating Articles

#PUT /articles/:id

def update

  if  @article.update(article_params)
    redirect_to @article
  else
    render :edit
  end
end
## 13. Deleting Articles

delete "/articles/:id" destroy

def destroy

  @article.destroy
  redirect_to articles_path
end

Deployment on Heroku

*heroku login

*heroku create

*git add .

*git commit -am "Deploy on Heroku"

*git push heroku master

Deployment on DCA

## 1. Deploy the Article Web App on Linux Centos 7.x (test)

Install ruby and rails

references:

https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-centos-7

Connect remote server: (jsanch81 is a sudo user)

local$ ssh jsanch81@10.131.137.229 Password: *****

jsanch81@test$

verify and install rvm, ruby, rails, postgres and nginx

install rvm (https://rvm.io/rvm/install)

jsanch81@test$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

jsanch81@test$ \curl -sSL https://get.rvm.io | bash

reopen terminal app:

jsanch81@test$ exit

local$ ssh jsanch81@10.131.137.229 Password: *****

install ruby 2.4.1

jsanch81@test$ rvm list known jsanch81@test$ rvm install 2.4.1

install rails

jsanch81@test$ gem install rails

install postgres:

jsanch81@test$ sudo yum install -y postgresql-server postgresql-contrib postgresql-devel Password: *****

jsanch81@test$ sudo postgresql-setup initdb

jsanch81@test$ sudo vi /var/lib/pgsql/data/pg_hba.conf

original:

     host    all             all             127.0.0.1/32            ident
     host    all             all             ::1/128                 ident

     updated:

     host    all             all             127.0.0.1/32            md5
     host    all             all             ::1/128                 md5
run postgres:

  jsanch81@test$ sudo systemctl start postgresql
  jsanch81@test$ sudo systemctl enable postgresql
Create Database User:

  jsanch81@test$ sudo su - postgres

  jsanch81@test$ createuser -s pguser

  jsanch81@test$ psql

  postgres=# \password pguser
  Enter new password: changeme

  postgres=# \q

  jsanch81@test$ exit
Setup RAILS_ENV and PORT (3000 for dev, 4000 for testing or 5000 for production)

     jsanch81@test$ export RAILS_ENV=test
     jsanch81@test$ export PORT=3001
open PORT on firewalld service:

     jsanch81@test$ sudo firewall-cmd --zone=public --add-port=4000/tcp --permanent
     jsanch81@test$ sudo firewall-cmd --reload
clone de git repo, install and run:

     jsanch81@test$ cd Documents
     jsanch81@test$ git clone https://github.com/st0263eafit/rubyArticulosEM.git
     jsanch81@test$ cd TopicosTelematica
     jsanch81@test$ cd trabajo
     jsanch81@test$ bundle install
     jsanch81@test$ rake db:drop db:create db:migrate
     jsanch81@test$ export RAILS_ENV=test
     jsanch81@test$ export PORT=3001
     jsanch81@test$ rails server
Prefix Verb URI Pattern Controller#Action

                          GET "/articles" index                welcome#index
                          POST "/articles" create              articles#create
                          DELETE "/articles/:id" destroy       articles#destroy
                          GET "/articles/:id" show             articles#show
                          GET "/articles/new" new              articles#new
                          GET "/articles/:id/edit" edit        articles#edit
                          PATCH "/articles/:id" update         articles#update
                          PUT "/articles/:id" update           articles#update
               root       GET  welcome/index                   welcome#index
               SETUP Centos 7.1 in production With Apache Web Server and Passenger.

               Install Apache Web Server

                 jsanch81@prod$ sudo yum install httpd
                 jsanch81@prod$ sudo systemctl enable httpd
                 jsanch81@prod$ sudo systemctl start httpd

                 test in a browser: http://10.131.137.236
               Install YARN (https://yarnpkg.com/en/docs/install) (for rake assets:precompile):

               Install module Passenger for Rails in HTTPD (https://www.phusionpassenger.com/library/install/apache/install/oss/el7/):

                 jsanch81@prod$ gem install passenger

                 jsanch81@prod$ passenger-install-apache2-module
               when finish the install module, add to /etc/http/conf/httpd.conf:

                   LoadModule passenger_module /home/jsanch81/.rvm/gems/ruby-2.4.1/gems/passenger-5.1.7/buildout/apache2/mod_passenger.so
                   <IfModule mod_passenger.c>
                     PassengerRoot /home/jsanch81/.rvm/gems/ruby-2.4.1/gems/passenger-5.1.7
                     PassengerDefaultRuby /home/jsanch81/.rvm/gems/ruby-2.4.1/wrappers/ruby
                   </IfModule>
               Configure the ruby rails app to use passenger (https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/apache/oss/el7/deploy_app.html):

               summary:

                 - clone the repo to /var/www/myapp/rubyArticulosEM

                 jsanch81@prod$ cd /var/www/myapp/rubyArticulosEM

                 jsanch81@prod$ bundle install --deployment --without development test

                 - Configure database.yml and secrets.yml:

                 jsanch81@prod$ bundle exec rake secret
                 jsanch81@prod$ vim config/secrets.yml

                 production:
                   secret_key_base: the value that you copied from 'rake secret'

                 jsanch81@prod$ bundle exec rake assets:precompile db:migrate RAILS_ENV=production
               add articles.conf to /etc/httpd/conf.d/myapp.conf:

                 <VirtualHost *:81>
                     ServerName 10.131.137.236

                     #Tell Apache and Passenger where your app's 'public' directory is
                     DocumentRoot /var/www/sicmu/code/topicos/public

                     PassengerRuby /home/jsanch81/.rvm/gems/ruby-2.4.1/wrappers/ruby

                     #Relax Apache security settings
                     <Directory /var/www/sicmu/code/topicos/public>
                         Allow from all
                         Options -MultiViews
                         #Uncomment this if you're on Apache >= 2.4:
                         #Require all granted
                     </Directory>
                 </VirtualHost>
               restart httpd

                 jsanch81@prod$ sudo systemctl restart httpd

                 test: http://10.131.137.239
