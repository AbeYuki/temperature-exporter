from fastapi import FastAPI, Response
from prometheus_client import CollectorRegistry, Gauge, generate_latest, CONTENT_TYPE_LATEST
from os import environ
import psutil, logging, asyncio

logger = logging.getLogger('uvicorn')

app = FastAPI()

# 非同期関数で温度を取得
async def fetch_temp(registry):
    try:
        temperatures = psutil.sensors_temperatures()
        if not temperatures:
            logger.info("温度情報は利用できません。")
            cpu_temp_gauge = Gauge('cpu_temperature', 'Temperature of the CPU', ['sensor'], registry=registry)
            return None
        for name, entries in temperatures.items():
            for entry in entries:
                cpu_temp_gauge = Gauge('cpu_temperature', 'Temperature of the CPU', ['sensor'], registry=registry)
                cpu_temp_gauge.labels(sensor=name).set(entry.current)
                logger.info(f"{name}: {entry.current}°C")
                return f"{name}: {entry.current}°C"
    except Exception as e:
        logger.error(f"温度取得時にエラーが発生しました: {e}")

# メトリクスの取得
@app.get("/metrics")
async def get_metrics():
    registry = CollectorRegistry()
    await fetch_temp(registry)
    return Response(generate_latest(registry), media_type=CONTENT_TYPE_LATEST)

if __name__ == "__main__":
    import uvicorn
    from os import environ

    host = environ.get("HOST_IP", "0.0.0.0")
    port = int(environ.get("PORT", 8000))

    uvicorn.run("main:app", host=host, port=port, reload=True)
