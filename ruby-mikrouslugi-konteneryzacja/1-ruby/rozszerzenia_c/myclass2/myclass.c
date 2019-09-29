#include "ruby.h"
#include "3d.c"
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
static VALUE t_transform3Into2(VALUE self, VALUE x,VALUE y,VALUE z, VALUE cx,VALUE cy,VALUE cz, VALUE thx,VALUE thy,VALUE thz) {
  // DATA
  unsigned char rxA = 0;
  unsigned char ryA = 0;
  VALUE arr;
  // CODE
  transform3Into2_NEW(&rxA,&ryA, x,y,z, cx,cy,cz, thx,thy,thz); 
  arr = rb_ary_new();
  rb_ary_push(arr, CHR2FIX(rxA));
  rb_ary_push(arr, CHR2FIX(ryA));
  return arr;
} // t_transform3Into2
VALUE cMyClass;
void Init_MyClass() {
  cMyClass = rb_define_class("MyClass", rb_cObject);
  rb_define_method(cMyClass, "initialize", t_init, 0);
  rb_define_method(cMyClass, "add", t_add, 1);
  rb_define_method(cMyClass, "transform3Into2", t_transform3Into2, 9);
} // Init_MyClass