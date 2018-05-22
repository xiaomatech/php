wget http://cn2.php.net/distributions/php-7.2.5.tar.gz
tar -zxvf php-7.2.5.tar.gz

yum install -y libzookeeper gperftools-libs libxml2-devel gd-devel curl-devel pcre-devel librdkafka-devel librabbitmq-devel GraphicsMagick-devel hiredis-devel libmemcached-devel protobuf-devel leveldb-devel

cd php-7.2.5
./configure --prefix=/opt/php --with-config-file-path=/opt/php/etc --with-zlib --enable-wddx --with-gd --enable-shared --enable-mysqlnd --enable-embedded-mysqli --with-iconv --enable-shmop --enable-inline-optimization --enable-mbregex --enable-fpm --enable-mbstring --with-openssl --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-gettext --enable-session --with-curl --with-fpm-user=nobody --with-fpm-group=nobody --enable-exif --enable-opcache --enable-xml --enable-ldap --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-bcmath --disable-fileinfo

cd ext
cd ldap
/opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install
cd ../sysvmsg
/opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install
cd ../sysvshm
/opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install


make && make install

/opt/php/bin/pecl install mongodb ds protobuf zookeeper grpc msgpack stomp rdkafka SeasLog memcached redis yac yaconf yar yaf leveldb gmagick
/opt/php/bin/pecl install channel://pecl.php.net/yac-2.0.2  channel://pecl.php.net/leveldb-0.2.1 channel://pecl.php.net/gmagick-2.0.5RC1


wget https://github.com/shukean/monip/archive/php7.zip -O monip.zip
wget https://github.com/youzan/zan/archive/v3.1.0.zip -O zan.zip
wget https://github.com/php-zookeeper/php-zookeeper/archive/master.zip -O php-zookeeper.zip
wget https://github.com/jonnywang/phone/archive/master.zip -O phone.zip
wget https://github.com/chuan-yun/Molten/archive/master.zip -O Molten.zip

unzip Molten.zip && cd Molten-master && /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config --enable-zipkin-header=yes && make && make install
unzip monip.zip && cd monip-php7 && /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install
unzip phone.zip && cd phone-master && /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install
unzip zan.zip && cd zan-3.1.0/zan-extension && /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config --enable-openssl --enable-async-redis --enable-jemalloc --enable-zan --enable-mysqlnd && make && make install
unzip php-zookeeper.zip && cd php-zookeeper-master && /opt/php/bin/phpize && ./configure --with-php-config=/opt/php/bin/php-config && make && make install

yum install -y rubygems ruby-devel
yum install -y rpm-build rpmdevtools
fpm -f -s dir -t rpm -v 7.2.5 -n php -C /opt/php --rpm-init /etc/init.d/php-fpm --prefix /opt/php -d curl -d libzookeeper -d openssl -d pcre -d readline -d gd -d librdkafka -d libxml2 -d librabbitmq  -d hiredis -d GraphicsMagick -d leveldb -d libmemcached
