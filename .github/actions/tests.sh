#!/bin/bash

set -e
npx cypress run  --config integrationFolder=plugins/themes/classic/cypress/tests/functional

