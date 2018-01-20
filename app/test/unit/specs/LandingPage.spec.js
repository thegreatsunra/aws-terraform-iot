import LandingPage from '@/components/views/LandingPage'
/* eslint-disable no-undef */
describe('LandingPage.vue', () => {
  it('should have the right data.title string', () => {
    const data = LandingPage.data()
    expect(data.title).toBe('Welcome to your new project!')
  })
  it('should correctly add 1 and 2', () => {
    const methods = LandingPage.methods
    expect(methods.sum(1, 2)).toBe(3)
  })
})
/* eslint-enable */
