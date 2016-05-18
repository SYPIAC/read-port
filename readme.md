#ruby
sudo apt-get install ruby
#rvm
curl -sSL https://get.rvm.io | bash -s stable
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#ruby 2.2.2
bash -l
rvm use 2.2.2
#libraries
gem install bundler

bundle install
#launch program
ruby main.rb
