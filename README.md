# Chocobo

Backbon-ify your iOS models and make it extremely easy to communicate with a RESTful API. Provides an easy API to connect, communicate and return success/failure events.

## Installation

Chocobo is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "Chocobo"

## Usage

Chocobo allows you to easily create async models/collections in your iOS app to communicate easily with a RESTful API.

### Models

Extend your model from the Model object and specify all the attributes using properties.

```c
@interface User : Model

@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *email;

@end
```

Next you will need to override the models method 'updateModelWithJson:'

```c
-(void) updateModelWithJson:(NSDictionary *)json
{
    NSDictionary *attributes = [json valueForKey:@"user"];
    self.userId = [attributes valueForKey:@"id"];
    self.firstName = [attributes valueForKey:@"first_name"];
    self.lastName = [attributes valueForKey:@"last_name"];
    self.email = [attributes valueForKey:@"email"];
}
```

Now you can call:

```
[self fetchFromEndpoint:@"login.json" withParams:parameters onSuccess:^(id responseObject) {

        NSLog(@"Do Something with your response object here");

    } onFailure:^(NSError *error)  {

        NSLog(@"Do something with the error");

    }];
```

### Collections

Collections will extend off the Collection object.

```c
#import "Collection.h"

@interface Users : Collection

@end
```

Your collection will then need to overide 2 functions

```c
-(id)model
{
    return @"User";
}

-(NSString *)collectionEndpoint
{
    return @"users.json";
}
```

This will allow the collection to automatically grab all the models from the collection
endpoint and set them in the models array.

Accessing the models in a collection are easy. Just use the models accessor.

```c
[[collection models] objectAtIndex: 0];
```

### Has Many Relationships

Setting up a has many relationship in your model is easy. Set up an NSMutableArray as a property on the
model of the model type that the relationship is set.

```c
# models/user.h

@property (nonatomic, retain) NSMutableArray *accounts;
```

Synthesize and set up the relationship in a loop inside your updateModelWithJson: function

```c
# models/user.m

@synthesize wells = _wells;

-(void) updateModelWithJson:(NSDictionary *)json
{
    for (NSDictionary* key in [json valueForKey:@"accounts"]) {
        Account *accountModel = [[Account alloc] init];
        [accountModel updateModelWithJson:key];

        [self.accounts addObject:account];
    }
}
```

### Has One Relationships

To setup a has one relationship on your models, set up a property on your model of the type you would like to set it up with.

```c
# models/user.h

#import 'Account.h'

@property (nonatomic, retain) Account *account;
```

And then in updateModelWithJson:

```c
# models/user.m

-(void) updateModelWithJson:(NSDictionary *)json
{
    Account *account = [[Account alloc] init];
    [account updateModelWithJson: [json valueForKey:@"account"]];
    self.account = account;
}
```

## License

** Creative Commons 3.0 - Attribution Sharealike**

You can remix, copy or use for both commercial and non-commercial products and services but you need to provide attribution for the original work in the source code to *"PetroFeed Inc."*. You must also share the original or any derivative under the same license. A description of the license can be found [here](http://creativecommons.org/licenses/by-sa/3.0).

---

Proudly brought to you by [PetroFeed](http://PetroFeed.com).


![Pedro](https://www.petrofeed.com/img/company/pedro.png)

