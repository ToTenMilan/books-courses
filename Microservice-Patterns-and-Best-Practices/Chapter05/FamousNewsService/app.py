import os
from flask import Flask

from views import famous_news
from models import db

# instantiate app
app = Flask(__name__)

# set config
app_settings = os.getenv('APP_SETTINGS')
app.config.from_object(app_settings)

db.init_app(app)

# register blueprints (boilerplate?)
app.register_blueprint(famous_news)

# run on 0.0.0.0:5000
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
