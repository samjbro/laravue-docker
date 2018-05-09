Feature('Home Page');

Scenario('Loads fine', (I) => {
   I.amOnPage('/');
   I.see('Hello World!!');
});