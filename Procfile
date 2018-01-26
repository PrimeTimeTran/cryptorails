redis: redis-server
web: rails server -p 3000
search: elasticsearch
fetch_worker: QUEUE=update_price rake resque:work
send_worker: QUEUE=price_serve rake resque:work
fetch_listener: rake resque:scheduler
