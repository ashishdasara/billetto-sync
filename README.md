# README

## Development

Configure PostgreSQL in `config/database.yml`, using
`config/database.yml.example` as a starting point, then run:

```sh
bundle install #install gems
bin/rails db:prepare # create db
bin/dev # run server, css, and solidqueue
```

Note: We are using separate databases for server data, solidqueue, solidcache and solidcable.

### Clerk authentication

Create a [Clerk application](https://dashboard.clerk.com/) and configure its
sign-in methods. Add both keys from its API keys page to Rails encrypted
credentials with `bin/rails credentials:edit`:

```yaml
clerk:
  publishable_key: pk_test_...
  secret_key: sk_test_...
```

Default configuration has already been added but may be removed soon.

Events can be loaded from Billetto into events table by running:

```sh
rake billetto:sync
```

Data gets synced with Billetto everyday at 12:00 AM.

Mission Control at `/jobs` requires HTTP Basic authentication. Configure its
credentials for the current environment with:

```sh
bin/rails mission_control:jobs:authentication:configure
```

The command prompts for a username, generates a password, and stores both in
encrypted Rails credentials. Restart the server after configuring them.

The event list is available at `/` (root) and `/events`, with 20 events per page and
numbered navigation. Navigation uses a count query to determine the total pages.
