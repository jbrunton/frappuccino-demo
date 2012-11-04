/*var casper = require('casper').create();

casper.start('http://www.google.fr/', function() {
    this.test.assertTitle('Google', 'google homepage title is the one expected');
    this.test.assertExists('form[action="/search"]', 'main form is found');
    this.fill('form[action="/search"]', {
        q: 'foo'
    }, true);
});

casper.then(function() {
    this.test.assertTitle('foo - Recherche Google', 'google title is ok');
    this.test.assertUrlMatch(/q=foo/, 'search term has been submitted');
    this.test.assertEval(function() {
        return __utils__.findAll('h3.r').length >= 10;
    }, 'google search for "foo" retrieves 10 or more results');
});

casper.run(function() {
    this.test.renderResults(true);
});*/

var casper = require('casper').create();

casper.start('http://localhost:3000/', function() {
    this.test.assertTitle('FrappuccinoDemo', 'title is FrappuccinoDemo');
    this.test.assertExists('#recent-posts', 'recent posts section is present');
    this.test.assertExists('#recent-posts li', 'there is a recent post');
    this.test.assertTextExists('Application Architecture', 'Application Architecture post exists');
});

casper.run(function() {
    this.test.renderResults(true);
});
