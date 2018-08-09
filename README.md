# Arcadia Power Coding Challenge: Building an API

A Rails API that serves data on User, Account, and Bill.
The API serves two types of user: 1) An authenticated customer, 2) an authenticated admin.

Features:
1) An authenticated customer can:
view her billing history, account information, edit accounts, and pay bills
2) An admin can:
view aggregate data on user, accounts, and bills
perform all CRUD on actions on User, Account, Bill resources

### Installation

Clone the repository by running:

```
git clone https://github.com/IngridWong0715/arcadia-power-challenge.git
```

Install dependencies using Bundler:

```
cd arcadia-power-challenge
bundle install

```

Run migrations:

```
rake db:migrate

```

Start up the server and navigate to localhost:3000

```
rails s
```

## Built With

* [Ruby On Rails](https://rubyonrails.org/)


## Authors

* **Ingrid Wong** - *Initial work* - [IngridWong0715](https://github.com/IngridWOng0715)
