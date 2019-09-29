#include "ruby.h"

static VALUE t_init(VALUE self)
{
  VALUE arr;
  arr = rb_ary_new();
  rb_iv_set(self, "@arr", arr);
  return self;
} // t_init
static VALUE t_add(VALUE self, VALUE anObject)
{
  VALUE arr;
  arr = rb_iv_get(self, "@arr");
  rb_ary_push(arr, anObject);
  return arr;
} // t_add
VALUE cMyClass;
void Init_MyClass() {
  cMyClass = rb_define_class("MyClass", rb_cObject);
  rb_define_method(cMyClass, "initialize", t_init, 0);
  rb_define_method(cMyClass, "add", t_add, 1);
} // Init_MyClass
