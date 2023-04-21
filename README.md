# Write into Google BigQuery

## Description

This GitHub Action can be used to write data to Google BigQuery from within a GitHub workflow.
The GitHub Action authenticates with a Google Cloud Service Account and uses the provided token for writing to BigQuery.
It sends a POST request against the `insertAll` [API endpoint](https://cloud.google.com/bigquery/docs/reference/rest/v2/tabledata/insertAll).

## Usage

> ##### Note: this action requires [`actions/checkout@v3`](https://github.com/actions/checkout) to be run first

```yaml
- name: Checkout
  uses: actions/checkout@v3

- name: Collect data
  run: |
    echo "TIMESTAMP=$(date --utc +%FT%T%Z)" >> $GITHUB_ENV

- name: Write to DWH
  uses: Staffbase/bigquery-github-action@v1.0.3
  with:
    credentials_json: ${{ secrets.YOUR_SERVICE_ACCOUNT_KEY }}
    bigquery_project: bq-your-project-id
    bigquery_dataset: bq-your-dataset-id
    bigquery_table: bq-your-table-id
    payload_json: '{ "property": "${{ env.TIMESTAMP }} this is a test"}'
```

## Action Spec:

### Inputs

| Input              | Description                                                  | Required |
| ------------------ | ------------------------------------------------------------ | -------- |
| `credentials_json` | The credentials key for the Service Account user used for authentication in JSON format. This is forwarded to the [`google-github-actions/auth`](https://github.com/google-github-actions/auth) action. | true     |
| `token_lifetime`   | The lifetime of the generated auth token in seconds. The default is 30s. This is forwarded to the [`google-github-actions/auth`](https://github.com/google-github-actions/auth) action. | false    |
| `bigquery_project` | The Project ID of the project to write to.                   | true     |
| `bigquery_dataset` | The Dataset ID inside the project to write to.               | true     |
| `bigquery_table`   | The Table ID inside the dataset to write to.                 | true     |
| `payload_json`     | The payload to be written into the referenced table in JSON format. It must reflect the schema of the table. In the above example the `property` refers to the column name in the table `bigquery_table` and `${{ env.TIMESTAMP }} this is a test` is the value written into that column. | true     |
| `timestamp_property_to_add`   | A column name in the `bigquery_table` which is of type `TIMESTAMP`. If provided the a property with this name and the current timestamp as value (in UTC) is added to `payload_json`. | false     |

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## License

This project is licensed under the Apache-2.0 License - see the [LICENSE.md](LICENSE) file for details.
