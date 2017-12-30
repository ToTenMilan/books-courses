/***
 * Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
***/
import "hello_angular/polyfills";

import { Component, NgModule    } from "@angular/core";
import { BrowserModule          } from "@angular/platform-browser";
import { FormsModule            } from "@angular/forms";
import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
import { Http, HttpModule } from "@angular/http";

var CustomerSearchComponent = Component({
  selector: "shine-customer-search",
  template: '\
<header> \
  <h1 class="h2">Customer Search</h1> \
</header> \
\
<section class="search-form"> \
  <form> \
    <label for="keywords" class="sr-only">Keywords></label> \
    <input type="text" id="keywords" name="keywords" \
           placeholder="First Name, Last Name, or Email Address"\
           class="form-control input-lg" \
           bind-ngModel="keywords"\
           on-ngModelChange="search($event)">\
\
  </form> \
</section> \
\
<section class="search-results"> \
  <header> \
    <h1 class="h3">Results</h1> \
  </header> \
  <ol class="list-group"> \
    <li *ngFor="let customer of customers" class="list-group-item clearfix"> \
      <h3 class="pull-right"> \
        <small class="text-uppercase">Joined</small> \
        {{customer.created_at}}\
      </h3> \
      <h2 class="h3"> \
        {{ customer.first_name }} {{ customer.last_name }}\
        <small>{{ customer.user_name }}</small> \
      </h2> \
      <h4>{{ customer.email }}</h4> \
    </li> \
  </ol> \
</section> \
  '
}).Class({
  // constructor: function() {
  //   this.customers = null;
  //   this.keywords = "";
  // },
  constructor: [
    Http, // this needs HttpModule imported by NgModule
    function(http) {
      this.customers = null;
      this.http = http; // this needs Http in array above
      this.keywords = '';
    }
  ],

  search: function($event) {
    var self = this;
    // request
    self.keywords = $event;
    if (self.keywords.length < 3) {
      return;
    }

    self.http.get( // this needs this.http in constructor
      "/customers.json?keywords=" + self.keywords // RAILS ANGULAR Connection
    ).subscribe(
    // response
      function(response) {
        self.customers = response.json().customers
      },
      // response errors
      function(response) {
        window.alert(response)
      }
    );
  },
});


var CustomerAppModule = NgModule({
  imports:      [ BrowserModule, FormsModule, HttpModule ],
  declarations: [ CustomerSearchComponent ],
  bootstrap:    [ CustomerSearchComponent ]
})
.Class({
  constructor: function() {}
});

platformBrowserDynamic().bootstrapModule(CustomerAppModule);


// <!-- before was one way binding bindon-ngModel="keywords" -->
// <span class="input-group-btn"> \
//         <input type="submit" value="Find Customers"\
//          class="btn btn-primary btn-lg"\
//          on-click="search()">\
//       </span> \
