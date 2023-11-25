# temperature-exporter
Raspberry Pi の CPU 温度を取得する exporter

## environment
環境変数でアクセス元の IP を指定できる  
デフォルトは 0.0.0.0
```
HOST_IP=192.168.1.1
```
環境変数で アプリケーションの port を指定できる
デフォルトは 8000
```
PORT=9101
```

## docker

```
docker run -itd -p 8000:8000 abeyuki/teperature-exporter:latest
```

## kubernetes

```
kubectl create deployment temperature-exporter --image=abeyuki/temperature-exporter --port=8000
```

## eporter path

```
curl http://127.0.0.1:8000/metrics
```