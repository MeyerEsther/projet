import { ApprojectPage } from './app.po';

describe('approject App', () => {
  let page: ApprojectPage;

  beforeEach(() => {
    page = new ApprojectPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
