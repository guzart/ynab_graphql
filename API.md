## Budget

```json
{
  "data": {
    "budget": {
      "id": "string",
      "name": "string",
      "last_modified_on": "Unknown Type: string,null",
      "date_format": {
        "locale": "Unknown Type: string,null"
      },
      "currency_format": {
        "locale": "Unknown Type: string,null"
      },
      "accounts": [
        {
          "id": "string",
          "name": "string",
          "type": "Checking",
          "on_budget": true,
          "closed": true,
          "note": "Unknown Type: string,null",
          "balance": 0,
          "cleared_balance": 0,
          "uncleared_balance": 0
        }
      ],
      "payees": [
        {
          "id": "string",
          "name": "string",
          "transfer_account_id": "Unknown Type: string,null"
        }
      ],
      "payee_locations": [
        {
          "id": "string",
          "payee_id": "string",
          "latitude": "Unknown Type: string,null",
          "longitude": "Unknown Type: string,null"
        }
      ],
      "category_groups": [
        {
          "id": "string",
          "name": "string",
          "hidden": true
        }
      ],
      "categories": [
        {
          "id": "string",
          "category_group_id": "string",
          "name": "string",
          "hidden": true,
          "note": "Unknown Type: string,null",
          "budgeted": 0,
          "activity": 0,
          "balance": 0
        }
      ],
      "months": [
        {
          "month": "string",
          "note": "Unknown Type: string,null",
          "to_be_budgeted": "Unknown Type: number,null",
          "age_of_money": "Unknown Type: number,null",
          "categories": [
            {
              "id": "string",
              "category_group_id": "string",
              "name": "string",
              "hidden": true,
              "note": "Unknown Type: string,null",
              "budgeted": 0,
              "activity": 0,
              "balance": 0
            }
          ]
        }
      ],
      "transactions": [
        {
          "id": "string",
          "date": "string",
          "amount": 0,
          "memo": "Unknown Type: string,null",
          "cleared": "cleared",
          "approved": true,
          "flag_color": "Unknown Type: string,null",
          "account_id": "string",
          "payee_id": "Unknown Type: string,null",
          "category_id": "Unknown Type: string,null",
          "transfer_account_id": "Unknown Type: string,null",
          "import_id": "Unknown Type: string,null"
        }
      ],
      "subtransactions": [
        {
          "id": "string",
          "transaction_id": "string",
          "amount": 0,
          "memo": "Unknown Type: string,null",
          "payee_id": "Unknown Type: string,null",
          "category_id": "Unknown Type: string,null",
          "transfer_account_id": "Unknown Type: string,null"
        }
      ],
      "scheduled_transactions": [
        {
          "id": "string",
          "date_first": "string",
          "date_next": "string",
          "frequency": "never",
          "amount": 0,
          "memo": "Unknown Type: string,null",
          "flag_color": "Unknown Type: string,null",
          "account_id": "string",
          "payee_id": "Unknown Type: string,null",
          "category_id": "Unknown Type: string,null",
          "transfer_account_id": "Unknown Type: string,null"
        }
      ],
      "scheduled_subtransactions": [
        {
          "id": "string",
          "scheduled_transaction_id": "string",
          "amount": 0,
          "memo": "Unknown Type: string,null",
          "payee_id": "Unknown Type: string,null",
          "category_id": "Unknown Type: string,null",
          "transfer_account_id": "Unknown Type: string,null"
        }
      ]
    },
    "server_knowledge": 0
  }
}
```
