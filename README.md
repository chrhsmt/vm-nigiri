vm-nigiri
=============

vm-nigiri

## install and run

```
bundle install --path vendor/bundle
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rackup
```

## web

```
open htto://localhost:9292
```

## API

returning json format data.

### instance list

```
curl -XGET http://localhost:9292/instances
```

### create instance 

```
curl -XPOST -d "" http://localhost:9292/instance
```

### delete instance

```
curl -XDELETE http://localhost:9292/instance/:id
```

## 成果物

### ソースコード

https://github.com/chrhsmt/vm-nigiri/

### データベーススキーマ

本ソースコード内のdb/schema.rb
https://github.com/chrhsmt/vm-nigiri/blob/master/db/schema.rb

### マシンイメージブートスクリプト

本ソースコード内、script/rc.local
https://github.com/chrhsmt/vm-nigiri/tree/master/scripts/rc.local

### オートスケール

出来てません！

### その他

本ソースコード内、script/*.sh


