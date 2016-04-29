# opentie
[![Circle CI](https://circleci.com/gh/opentie/opentie/tree/master.svg?style=svg)](https://circleci.com/gh/opentie/opentie/tree/master)

## How to deploy

TODO:

### Environment Variables

| Middleware   | Environment Variable |
|:-------------|:---------------------|
| Redis        | `REDIS_URL`          |
| PostgreSQL   | `DATABASE_URL`       |
| MongoDB      | `MONGO_URL`          |
| SMTP Server  | `SMTP_SETTINGS`      |

#### Example: `SMTP_SETTINGS`

It is written as a JSON.

```
SMTP_SETTINGS='{ "address": "localhost", "port": 25 }'
```

The properties of JSON are defined in ActionMailer (refer to [Action Mailer Basics — Ruby on Rails Guides](http://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration)).
