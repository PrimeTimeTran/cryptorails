web: rails server -p 3000
redis: redis-server
worker: QUEUE=update_price rake resque:work
job_fetch_price: rake resque:scheduler