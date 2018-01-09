# README

## CryptoRails Setup Instructions
1. Clone the repo
    - `git clone https://github.com/PrimeTimeTran/cryptorails`

2. Bundle Install
    - `bundle install`

3. Start the redis server
    - `redis-server`

4. Start the resque scheduler
    - `rake resque:scheduler`

5. Start the rails server
    - `rails s`