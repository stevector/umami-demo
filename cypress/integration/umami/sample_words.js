var ingredients = require('./../../source_data/ingredients.json');
var formats = require('./../../source_data/format.json');
var intensifiers = require('./../../source_data/intensifier.json');
var verbs = require('./../../source_data/verb.json');


function airtableRecords(json) {
    return json.records.map(record => record.fields);
}

module.exports = {
    'intensifiers': airtableRecords(intensifiers),
    'formats': airtableRecords(formats),
    'verbs': airtableRecords(verbs),
    'ingredients': airtableRecords(ingredients),
    'sentence_structure': [
        [
            'intensifiers',
            'formats',
            'verbs',
            'ingredients',
        ]
    ],
    'sentence': function() {
        for (var i = 0, len = this.sentence_structure[0].length, text = ""; i < len; i++) {
             text += this.getWord(this.sentence_structure[0][i]) + " ";
          }
          return text;
     },
     'getWord': function(key) {
        const record = this[key].shift();
        this[key].push(record);
        return record.Name;
     }
}