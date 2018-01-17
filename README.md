# Cryptorails Backend
Welcome Aboard! Major dependencies, versions, & tools used by CryptoRails as well as tips to get you going below.

- `ruby 2.4.0`
- `rails 5.1.4`
- `postgres 10.1`
-  [Overmind](https://github.com/DarthSim/overmind) for process management
- `environment keys`. The .env.sample file is a sample of the keys you'll need to access various services required to run the CryptoRails backend. Ask your team lead to provide you with the real .env file containing **necessary** environment variables.

# Setup Instructions
Hopefully, following the instructions below will get you up in running if you've got the necessary depenedcies hooked up. Don't hesitate to ask for support on getting your development environment up and running though. We understand it can be difficult depending on your environment.

#### 1. Clone the repo:
    git clone https://github.com/PrimeTimeTran/cryptorails

There's a `.ruby-version` included with the repo, RVM should set your environment to use `ruby 2.4.0` when you `cd` into the directory. Confirm by running `ruby -v` after you've cloned the repo & `cd`'d in.

#### 2. Install Ruby Dependencies
    bundle install

At the time of this writing, Redis 3.3.0 is required due to a [bug with Redis 4.0](https://github.com/rails/rails/issues/30527). If you get errors complaining about current version then you can run `bundle update redis` which will force the version specified in the gemfile to install, **3.3.0**

#### 3. Run the process manager(we like Overmind)
    overmind s

This is the process manager we use. You can learn more about why we prefer it by reviewing this [guide](https://evilmartians.com/chronicles/introducing-overmind-and-hivemind). If you take a peek at the Procfile located in the root directory, you'll see that Overmind will manage starting both Rails & Redis servers, required workers for grabbing & sending data related to pricing, as well as a a resque scheduler which fetches data from the Coinbase API at designated intervals.

# Completed Setup
At this point, you should see a screen that looks something like this.

![Overmind](images/overmind-start.jpg)

On the left, Overmind lists which processes logs you're seeing. We define the processes required for running our app, redis, price_fetch, web, fetch_worker, send_worker, etc in our `Procfile` located in the root directory, this is the file sought & executed when we run `overmind s`.

## Tips & tricks

#### Debugging
Included in the repo is a .pryrc file. If you're new to **pry** we highly recommend you [review the documentation](https://github.com/pry/pry) because it's a powerful tool. It makes debugging much easier once you familiarize yourself with how to use it.

You can view local variables with `ls -l`, available instance & class methods with `ls`, where execution stops with `w`, and step through execution one line at a time with `n`.

These are powerful techniques in testing your assumptions about how the code is behaving as well as whether or not method calls **returned responses you expected**.

Make sure you read the documentation beause this is just the taste of the power of `pry`.

![Pry methods](images/pry.jpg)

 #### Styling
 Rubocop is also included in the repo. Rubocop will make you a better programmer, **period**.

 Once you've done your work, run `rubocop` and Rubocop will list for you warnings of offenses commited in terms of **code styling**. By reading the complaints Rubocop specifies and correcting, you'll improve your coding skills. [Bbatsov](https://github.com/bbatsov/ruby-style-guide) is the Ruby style guide used by Rubocop. Make sure you read the complaints carefully because they'll teach you a lot.

 Once you've made the corrections to the specified by Rubocop, add the changes & commit. With the help of Rubocop, you'll learn more about the nuances of Ruby as well as catch simple mistakes before they're pointed out in code review.

 ![Rubocop offenses](images/rubocop-offenses.jpg)