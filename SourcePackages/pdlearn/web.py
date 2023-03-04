from webServerConf import WebMessage, WebQrUrl, web_db, app

from datetime import date, datetime


class WebHandler:

    def __init__(self):
        with app.app_context():
            try:
                web_db.create_all()
            except Exception as e:
                pass

    def add_message(self, message):
        with app.app_context():
            try:
                msg = WebMessage(message.strip())
                web_db.session.add(msg)
                web_db.session.commit()
            except Exception as e:
                web_db.session.rollback()
                print(e)
                pass

    def add_qrurl(self, url):
        with app.app_context():
            try:
                qrurl = WebQrUrl(url)
                web_db.session.add(qrurl)
                web_db.session.commit()
            except Exception as e:
                web_db.session.rollback()
                print(e)
                pass
