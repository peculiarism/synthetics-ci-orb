# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/run-tests.sh
}

@test 'Use custom parameters' {
    export PARAM_API_KEY="DD_API_KEY"
    export PARAM_APP_KEY="DD_APP_KEY"
    export PARAM_CONFIG_PATH="./some/other/path.json"
    export PARAM_FAIL_ON_TIMEOUT="1"
    export PARAM_FILES="test1.json"
    export PARAM_LOCATIONS="aws:eu-west-1"
    export PARAM_PUBLIC_IDS="jak-not-now,jak-one-mor"
    export PARAM_SITE="datadoghq.eu"
    export PARAM_SUBDOMAIN="app1"
    export PARAM_TEST_SEARCH_QUERY="apm"
    export PARAM_TUNNEL="1"
    export PARAM_VERSION="v1.1.1"
    export DATADOG_CI_COMMAND="echo"

    result=$(RunTests)
    
    if ! echo $result | grep -q "synthetics run-tests --failOnTimeout --tunnel --config ./some/other/path.json --files test1.json --public-id jak-not-now --public-id jak-one-mor --search apm"
    then
      echo $result
      exit 1
    fi
}

@test 'Use default parameters' {
    export PARAM_API_KEY="DD_API_KEY"
    export PARAM_APP_KEY="DD_APP_KEY"
    export PARAM_CONFIG_PATH=""
    export PARAM_FAIL_ON_CRITICAL_ERRORS="0"
    export PARAM_FAIL_ON_TIMEOUT="1"
    export PARAM_FILES=""
    export PARAM_LOCATIONS=""
    export PARAM_PUBLIC_IDS=""
    export PARAM_SITE=""
    export PARAM_SUBDOMAIN=""
    export PARAM_TEST_SEARCH_QUERY=""
    export PARAM_TUNNEL="0"
    export PARAM_VERSION="v1.1.1"
    export DATADOG_CI_COMMAND="echo"

    result=$(RunTests)

    if ! echo $result | grep -q "synthetics run-tests --failOnTimeout"
    then
      echo $result
      exit 1
    fi
}