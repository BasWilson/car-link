const languages = require('../constants/lang');

module.exports = function langString(lang, key) {

    switch (lang) {
        case 'nl':
            return languages.nl[key];
        case 'en':
            return languages.en[key];
        default:
            break;
    }
}