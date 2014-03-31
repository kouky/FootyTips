#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

SpecBegin(Thing)

describe(@"Thing", ^{

  it(@"should do stuff", ^{
    expect(@"foo").to.equal(@"foo");
  });
  
});

SpecEnd
