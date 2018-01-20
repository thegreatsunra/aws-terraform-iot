import {Selector} from 'testcafe'

/* eslint-disable no-undef */
fixture `Getting Started`
  .page `http://localhost:8080`
/* eslint-enable */

const landingPage = Selector('._landing-page')
const title = Selector('.title')
const styleGuideButton = Selector('.btn--primary')

/* eslint-disable no-undef */
test('Landing Page', async test => {
  await test
    .expect(landingPage.exists).ok('The landing page exists')
})

test('Title', async test => {
  await test
    .expect(title.innerText).eql('WELCOME TO YOUR NEW PROJECT!')
})

test('Style Guide Route', async test => {
  await test
    .click(styleGuideButton)
    .expect(Selector('.drawer').exists).ok('drawer exists')
})

/* eslint-enable */
