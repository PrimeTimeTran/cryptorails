web: rails server -p 3000
redis: redis-server
fetch_worker: QUEUE=update_price rake resque:work
send_worker: QUEUE=price_serve rake resque:work
price_fetch: rake resque:scheduler
search: elasticsearch
