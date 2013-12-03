# Chocobo

[![Version](http://cocoapod-badges.herokuapp.com/v/Chocobo/badge.png)](http://cocoadocs.org/docsets/Chocobo)
[![Platform](http://cocoapod-badges.herokuapp.com/p/Chocobo/badge.png)](http://cocoadocs.org/docsets/Chocobo)

## Requirements

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

## License

** Creative Commons 3.0 - Attribution Sharealike**

You can remix, copy or use for both commercial and non-commercial products and services but you need to provide attribution for the original work in the source code to *"PetroFeed Inc."*. You must also share the original or any derivative under the same license. A description of the license can be found [here](http://creativecommons.org/licenses/by-sa/3.0).

---

Proudly brought to you by [PetroFeed](http://PetroFeed.com).


![Pedro](https://www.petrofeed.com/img/company/pedro.png)

