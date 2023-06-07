
describe('Jungle app', () => {

  it('increases the count of the cart when the add button is clicked', () => {
    cy.visit('http://localhost:3000/');
    cy.get('.nav-item.end-0')
    .invoke('text')
    .as('initialCount');
    cy.get('.btn').first().click({force: true});
    cy.get('.nav-item.end-0')
    .invoke('text')
    .as('updatedCount');

    cy.get('@initialCount').then(initialCount => {
      cy.get('@updatedCount').then(updatedCount => {
        const initialCountNumber = extractCartCount(initialCount);
        const updatedCountNumber = extractCartCount(updatedCount);
        expect(updatedCountNumber).to.be.greaterThan(initialCountNumber);
      });
    });
  });
});

function extractCartCount(text) {
  const matches = text.match(/\((\d+)\)/);
  return matches ? parseInt(matches[1]) : 0;
}