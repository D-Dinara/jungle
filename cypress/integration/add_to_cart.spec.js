describe('add_to_cart', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('can add product to cart by clicking the button', () => {
    cy.contains('My Cart (0)')
    cy.get(".products article button").first().click({force: true})
    cy.contains('My Cart (1)')
  })
}) 