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

#### 1a. Install tesseract 3.0+
Well, this depends on your system.
Check your package manager or check https://code.google.com/p/tesseract-ocr/downloads/list

#### 2. Seperate user
Create a seperate user `ingress-stats-db` for Ingress Stats DB

    $ useradd --comment "Ingress Stats DB" --create-home --user-group --system ingress-stats-db

#### 3. Database
We recommend using a PostgreSQL database.

    # Create a user for Ingress Stats DB.
    sudo -u postgres -H createuser -d ingress-stats-db

#### 4. Ingress Stats DB

    # Clone Ingress Stats DB repository
    sudo -u git -H git clone https://gitlab.bn3t.de/fuchsi/ingress-stats-db.git

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

Start the unicorn production server with

    cd /home/ingress-stats-db/ingress-stats-db

    sudo -u ingress-stats-db -H scripts/web

and surf to http://localhost:8080

### Run in development mode

Start the Rails development server with

    bundle exec rails s

and surf to http://localhost:3000
