# Exchange Rate API

Fetch the exchange rate for various currencies based on the [Exchange Rate API](https://exchangerate-api.com/). This is a wrapper around the API and is not affiliated with the Exchange Rate API. Responses are cached for 1 hour before re-fetching.

- **Example Request:** `/v1/rates/usd,gbp,eur,cad`
    - The currency request can be singular or CSV

**Response:**

```json
{
    "status": "ok",
    "data": {
        "usd": 1,
        "gbp": 0.824978,
        "eur": 0.934425,
        "cad": 1.33451
    }
}
```

## Run Locally

**Pre-requisites:** [Elixir](https://elixir-lang.org/install.html)

```bash
  git clone https://github.com/zaneh/exchange-rate-api
  cd exchange-rate-api
  mix deps.get
  mix run --no-halt
```
