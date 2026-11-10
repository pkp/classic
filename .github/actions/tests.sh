#!/bin/bash

set -e
npx cypress run --config specPattern=plugins/themes/classic/cypress/tests/functional

