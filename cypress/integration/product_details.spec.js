
describe('Jungle app', () => {

  it('visits the homepage', () => {
   cy.visit('http://localhost:3000/')
  });

  it("should navigate to the product detail page when a product is clicked", () => {
    cy.visit('http://localhost:3000/');
    
    cy.get('.product-link').first().click();
  });

});