const sample_words = require('./sample_words.js');





function setTitle(cy, sample_words) {
    var d = new Date();          
    var n = d.getTime(); 
    const title = sample_words.sentence();
    cy.get('input[name="title[0][value]"]').type(title + n, {force: true})
}

function uploadImage(cy, Cypress, sample_words) {
    const imageName = sample_words.ingredients[sample_words.ingredients.length - 1].Name;
    const imageNameLower = imageName.replace(/\s+/g, '-').toLowerCase();

    cy.get('input[type=file]').then(subject => {
        // Adapted from From Cypress document: https://docs.cypress.io/api/utilities/blob.html#Examples  
        return cy.fixture('images/'  +  imageNameLower + '.jpg', 'base64').then((base64) => {
                return Cypress.Blob.base64StringToBlob(base64, "image/jpeg").then((blob) => {
                const el = subject[0]
                const testFile = new File([blob], 'logo.jpg', { type: 'image/jpeg' })
                const dataTransfer = new DataTransfer()
                dataTransfer.items.add(testFile)
                el.files = dataTransfer.files
            })
        })
    })

    cy.get('input[name="field_image[0][alt]"]').type('image alt', {force: true})
}


function logIn(cy, Cypress) {
    cy.visit('user');
    cy.get('input[name=name]').type(Cypress.env('DRUPAL_USERNAME'))
    cy.get('input[name=pass]').type(Cypress.env('DRUPAL_USERPASS') + '{enter}')
    cy.url().should('include', '/user')
}

describe('Hello world ', function(){
    context('Make some nodes', function(){      
    it('Logs in', function(){
        logIn(cy, Cypress);

        var i = 0;
        while (i < 100) {
//            cy.visit('node/add/article?failover_debug=1');
          cy.contains('Failover Debug').click();
          setTitle(cy, sample_words);
            //uploadImage(cy, Cypress, sample_words);
            cy.get('#edit-submit').click();
            cy.wait(500);
          i++;
        }
      })
    })
})
