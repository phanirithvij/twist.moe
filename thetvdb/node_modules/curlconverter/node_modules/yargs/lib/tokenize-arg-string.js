// take an un-split argv string and tokenize it.
module.exports = function (argString) {
  var i = 0
  var c = null
  var opening = null
  var args = []

  for (var ii = 0; ii < argString.length; ii++) {
    c = argString.charAt(ii)

    // split on spaces unless we're in quotes.
    if (c === ' ' && !opening) {
      i++
      continue
    }

    // don't split the string if we're in matching
    // opening or closing single and double quotes.
    var escaped = false
    if (ii > 0) {
      var previousCharacterIndex = ii - 1
      var previousCharacter = argString.charAt(previousCharacterIndex)
      escaped = previousCharacter === '\\'
    }
    if (c === opening && !escaped) {
      opening = null
      continue
    } else if ((c === "'" || c === '"') && !opening) {
      opening = c
      continue
    }

    // only include slashes if they are not escaping the quotes we're
    // currently inside
    var nextCharacter = null
    if (ii < argString.length - 1) {
      nextCharacter = argString.charAt(ii + 1)
    }
    if (c === '\\' && nextCharacter === opening) {
      continue
    }
    if (!args[i]) {
      args[i] = ''
    }
    args[i] += c
  }
  return args
}
