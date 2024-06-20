name: Trigger Shiny Update

on:
  schedule:
    - cron: '0 */4 * * *'  # Ejecutar cada 4 horas
  workflow_dispatch:  # Permitir la ejecución manual

jobs:
  trigger_update:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up R
        uses: r-lib/actions/setup-r@v2

      - name: Install dependencies
        run: |
          Rscript -e 'install.packages("httr")'

      - name: Run trigger script
        run: Rscript trigger_shiny_update.R
