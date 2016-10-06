# encoding: utf-8
# $Id: README.txt 350 2016-05-09 13:52:50Z e0c2425 $

This folder site_prism page objects for the FAST application.
all_page_objects.rb and helpers.rb requires the files in this
folder to implement a "page factory".

site_prism has elements, which is the generic add widget method.
The first argument is the name of the widget, subsequent arguments
are passed directly on to ::Capybara::Node::Finders#find to
find the element.

If you want to find an element by id:
    #the_id
If you want to find an element by class:
    .the_class
If you want to find an element by title:
    div[title='the_title']
To find a link whose name property is 'bob':
    a[name='bob']
To find a button whose id is 'fred':
    button#fred

If you want and to use any of the field matching filters, such as
disabled, checked, readonly, etc..., then you must define the
element as a field:
    element :page_element, :field, '#my_page_element'
Then calling wait_for_page_element on it will actually wait
for it to be enabled since Capybara finds only enabled fields by
default. If it doesn't or if you want to wait for a disabled field
to be on the page then you can pass filter options (disabled,
checked, readonly, etc) to wait_for_page_element:
    @page.wait_for_page_element(10, disabled: false)
Note, you can also use @page.wait_until_element_visible