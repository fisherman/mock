function mock -a _mock -a result -a code -d "Mock library for fish shell testing"
  set -l blacklisted "builtin" "functions" "eval" "command"

  if contains $_mock $blacklisted
    echo The function '"'$_mock'"' is reserved and therefore cannot be mocked.
    return 1
  else if not contains $_mock $_mocks
    function $_mock -V _mock -V result -V code 
      set -l args $argv

      # add result variable
      if test -z "$result"
        set result 0
      end

      if test -z "$code"
        set code ""
      end

      eval $code
      return $result
    end
  end
end

function unmock -a _mock
  functions -e $_mock
end
