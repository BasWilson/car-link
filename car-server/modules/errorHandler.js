const lang = require('./lang');

module.exports = function handleError(local, key) {
    console.error("[ERROR]", lang(local, key));
    return {
        error: lang(local, key)
    }
}