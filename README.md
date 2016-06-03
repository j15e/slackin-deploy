
## Slackin deploy

If you hate heroku, you have your own server...

If not, [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/rauchg/slackin/tree/master)
[https://github.com/rauchg/slackin]

```
cp env.example .env
# add values to .env file

# edit path to fit your need in slackin.sh file
vi slackin.sh

# add init.d script for slackin
sudo -i
cd /vagrant
cp slackin.sh /etc/init.d/slackin
chmod a+x /etc/init.d/slackin
update-rc.d slackin defaults
service slackin start

# edit server name in nginx-slackin.conf
ln -s /vagrant/nginx-slackin.conf /etc/nginx/sites-enabled/nginx-slackin.conf
service nginx reload

Voilà!

```