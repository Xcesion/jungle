describe('add product into cart functionality', () => {
  it('visit the homepage', () => {
    cy.visit('/')
  })
  it('lets you add a product to the cart and checks that cart count increases by 1', () => {
    cy.contains('My Cart (0)')
    cy.contains('Add').first().click({force: true})
    cy.contains('My Cart (1)')
  })
});