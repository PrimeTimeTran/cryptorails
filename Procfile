elastic: elasticsearch
redis: redis-server
web: rails server -p 3000
fetch_worker: QUEUE=update_price rake resque:work
send_worker: QUEUE=price_serve rake resque:work
scheduler: rake resque:scheduler
