# Project 1 - *LTCPFlicks*
LelandTranCodePathFlicks (sorry that's a mouthful)

LTCPFlicks is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [ ] Implement segmented control to switch between list view and grid view.
- [ ] Add a search bar.
- [ ] All images fade in.
- [ ] For the large poster, load the low-res image first, switch to high-res when complete.
- [ ] Customize the highlight and selection effect of the cell.
- [ ] Customize the navigation bar.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/c0xakAj.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://i.imgur.com/7Kdo6vt.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
- For some reason, my app was failing when I tried to embed the "endpoint" field in the URL string using the conventional 
"\(endpont)" syntax for formatting values in strings. Therefore, the NSURL initializer was returning null and my app would fail when it would get casted as a URL for the NSURLRequest. I instead just used String addition to embed the endpoint, which I'm expecting isn't a best practice, but it was my workaround.
- I got stuck with disabling the NS App Transport Security per domain because I set the NSExceptionAllowsInsecureHTTPLoads to YES, but I set it as a string as opposed to a boolean.
- The loading HUD wasn't showing up for a while even though I followed the example perfectly. Even when I set a breakpoint, the HUD didn't show up after I would step over the MBProgressHUD.showAdded() call. I decided to work on the remaining user stories and return to it later. When I came back to it, I tried breakpoint debugging again, and this time I put a breakpoint at the MBProgressHUD.hide() call and let it run until the .hide() call and saw that the HUD was in fact showing up. So I ended up realizing that I couldn't make any assumptions on how the debugger runs. I still need to learn and understand that much.

## License

Copyright 2017 Leland Tran

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
