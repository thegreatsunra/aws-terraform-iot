import { Selector } from 'testcafe'
/* eslint-disable no-undef */
fixture`Getting Started`
  .page`http://localhost:8080`
/* eslint-enable */

/* eslint-disable no-undef */
test('default e2e tests', async test => {
  await test
    .expect((Selector('.hello')).exists).ok()
    .expect(Selector('h1').innerText).eql('Welcome to Your Vue.js App')
    .expect((Selector('img')).exists).ok()
})
/* eslint-enable */
