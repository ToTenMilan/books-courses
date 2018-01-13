
import "polyfills";
import "babel-polyfill";

import { NgModule    } from "@angular/core";
import { BrowserModule          } from "@angular/platform-browser";
import { FormsModule            } from "@angular/forms";
import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
import { HttpModule } from "@angular/http";
import { CustomerSearchComponent } from 'CustomerSearchComponent';

var CustomerAppModule = NgModule({
  imports:      [
    BrowserModule,
    FormsModule,
    HttpModule ],
  declarations: [ CustomerSearchComponent ],
  bootstrap:    [ CustomerSearchComponent ]
})
.Class({
  constructor: function() {}
});

platformBrowserDynamic().bootstrapModule(CustomerAppModule);
