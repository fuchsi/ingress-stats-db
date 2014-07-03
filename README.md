## Ingress Stats DB

### Open Source Stats DB for Ingress using OCR

### Requirements
* Any Linux
* ruby 2.0+
* PostgreSQL or MySQL
* tesseract 3.0+

### Installation

#### 1. Install Ruby 2.0+
Well, this depends on your system.
Check your package manager.

#### 2. Seperate user
Create a seperate user `ingress-stats-db` for Ingress Stats DB

    $ useradd --comment "Ingress Stats DB" --create-home --user-group --system ingress-stats-db

#### 3. Database
We recommend using a PostgreSQL database.

    # Login to PostgreSQL
    sudo -u postgres psql -d template1

    # Create a user for GitLab.
    template1=# CREATE USER ingress-stats-db CREATEDB;

    # Create the GitLab production database & grant all privileges on database
    template1=# CREATE DATABASE ingress-stats-db_production OWNER ingress-stats-db;

    # Quit the database session
    template1=# \q

    # Try connecting to the new database with the new user
    sudo -u ingress-stats-db -H psql -d ingress-stats-db_production

#### 4. Ingress Stats DB

    # Clone Ingress Stats DB repository
    sudo -u git -H git clone https://gitlab.com/fuchsi/ingress-stats-db.git

    # Go to Ingress Stats DB dir
    cd /home/ingress-stats-db/ingress-stats-db

#### 5. Configure it

    cd /home/ingress-stats-db/ingress-stats-db

    # Copy the example config
    sudo -u ingress-stats-db -H cp config/settings.default.yml config/settings.yml

    sudo -u ingress-stats-db -H editor config/settings.yml

Configure DB Settings

    sudo -u ingress-stats-db -H editor config/database.yml

#### 6. Install gems

    cd /home/ingress-stats-db/ingress-stats-db

    # For PostgreSQL (note, the option says "without ... mysql")
    sudo -u ingress-stats-db -H bundle install --deployment --without development test mysql

    # Or if you use MySQL (note, the option says "without ... postgres")
    sudo -u ingress-stats-db -H bundle install --deployment --without development test postgres

#### 7. Initialize Database

    sudo -u ingress-stats-db -H bundle exec rake db:setup RAILS_ENV=production

#### 8. Compile assets

    sudo -u ingress-stats-db -H bundle exec rake assets:precompile RAILS_ENV=production

### Run in production mode
* tbd

### Run in development mode

Start the Rails development server with

    bundle exec rails s

and surf to http://localhost:3000
