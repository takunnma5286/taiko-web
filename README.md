# 太鼓ウェブ

Windows上で趣味で開発

## デバッグの開始
pythonの依存関係をpyenv上にインストールします  
python3.12.7をインストールしてない場合は[してきて](https://www.python.org/downloads/release/python-3127/)ください  
```
py -3.12 -m venv .venv
.venv/Scripts/activate
pip install -r requirements.txt
```

この作業は初回以外は必要ありません  
dockerを使用し、データベースサーバーを起動します

```
docker run --detach `
  --name taiko-web-mongo-debug `
  --volume taiko-web-mongo-debug:/data/db `
  --publish 27017:27017 `
  mongo
```

```
docker run --detach `
  --name taiko-web-redis-debug `
  --volume taiko-web-redis-debug:/data `
  --publish 6379:6379 `
  redis
```

サーバーを起動してください

```
.venv/Scripts/activate
flask run
```

### 引数一覧

ポートを変更したい場合
```
-p 5000
```

ファイル変更時に自動でリロード
```
--reload
```

## その他
### GoogleDriveの有効化
[Google Cloud](https://console.cloud.google.com/welcome)で任意の名前のプロジェクトを作成

- [Google Drive API](https://console.cloud.google.com/apis/library/drive.googleapis.com)
- [Google Picker API](https://console.cloud.google.com/apis/api/picker.googleapis.com/metrics)

を有効化

config.pyの`GOOGLE_CREDENTIALS`を変更
```python
GOOGLE_CREDENTIALS = {
    'gdrive_enabled': True,
    'api_key': 'API キー',
    'oauth_client_id': 'OAuth 2.0 クライアント ID',
    'project_number': 'プロジェクトのID',
    'min_level': None
}
```