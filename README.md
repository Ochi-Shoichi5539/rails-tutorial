# README
## このリポジトリについて
- rails tutorialアウトプット用のリポジトリです。

## 環境構築方法
### 1. 本リポジトリをcloneする
```
git clone [本リポジトリのURL]
```
### 2. コンテナのビルド
```
docker-compose build
```

### 3. データベース作成
```
docker-compose run app rake db:create
```

### 4. コンテナの立ち上げ
```
docker-compose up
```

### 5. コンテナに入る
```
docker exec -it [コンテナ名] /bin/bash
```

### 6. Webpacker Errorが出た時は、以下のコマンドを実行する
```
docker-compose run app rails webpacker:install
```
