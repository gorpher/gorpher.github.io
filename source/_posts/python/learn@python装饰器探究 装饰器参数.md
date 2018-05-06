
编写传参的装饰器

通常我们见到的简单装饰器这样的：

import json
import functools
 
def json_output(func):
    @functools.wraps(decorated)
    def inner(*args, **kwargs):
        result = func(*args, **kwargs)
        returnjson.dumps(result)
    returninner
 
@json_output
deff():
    return{'status': 'done'}

当装饰器应用于函数 f 上时，它接受 f 作为其参数，返回一个函数 inner ，且将他绑定到变量f上。

示例中我们编写的装饰器 json_output 只接受一个隐式参数——即被装饰的方法，在使用此装饰器时本身看上去是并没有参数的。然而有时候需要让装饰器自身带有一些需要的信息，从而使装饰器可以使用恰当的方式装饰方法。比如上面的例子中，我们想通过向装饰器传入不同的参数来控制输出结果的缩进(indent)和排序(sort)。我们可以这么做:

import json
import functools
 
def json_output(indent=None,sort_keys=False):
    def actual_decorator(func):
        @functools.wraps(func)
        def inner(*args, **kwargs):
            result = func(*args, **kwargs)
            returnjson.dumps(result,indent=indent,sort_keys=sort_keys)
        returninner
    returnactual_decorator
 
@json_output(indent=4)
deff():
    return{'status': 'done'}

理解传参的装饰器

初次看起来会觉得比较绕人，因为函数里嵌套了两个函数定义，然而实际上和之前一个版本的区别在于为了接收json序列化的参数多包装了一层，所以

@json_output(indent=4)
deff():
    return{'status': 'done'}
 
# 相当于
@actual_decorator
deff():
    return{'status': 'done'}

这样看起来就会明晰很多。

实际上, 装饰器里的 @ 后接收一个函数，该函数以被装饰的函数(例子中是f)为参数，并且返回一个函数。当需要在装饰函数的同时传入参数的话，那么就需要多包装一层，先传入参数(例子中是 indent=4 )返回一个装饰的函数(例子中是 actual_decorator ), 这个返回的的函数 就跟以前一样接受被装饰的函数(f)作为参数并且返回一个函数作为装饰最后的方法供调用。

传参和不传参的兼容

然而当我们像上面那样定义装饰器时，就不能这样调用:

import json
import functools
 
def json_output(indent=None,sort_keys=False):
    def actual_decorator(func):
        @functools.wraps(func)
        def inner(*args, **kwargs):
            result = func(*args, **kwargs)
            returnjson.dumps(result,indent=indent,sort_keys=sort_keys)
        returninner
    returnactual_decorator
 
@json_output
deff():
    return{'status': 'done'}

在实际的项目过程中，有时会出现这样的状况: 一开始写的装饰器时不需要使用时传参数的，后来发现有必要传参数，改好后原来不传参的装饰器不能正常使用了，这是修改原来使用的地方是项痛苦的事情。

这时候就需要对装饰器做一个兼容，使它在以下情况都可用:

@json_output
@json_output()
@json_output(indent=4)

具体做法如下:

import json
import functools
 
def json_output(decorated_=None,indent=None,sort_keys=False):
    ifdecorated_ and(indent orsort_keys):
        raise
 
    def actual_decorator(func):
        @functools.wraps(func)
        def inner(*args, **kwargs):
            result = func(*args, **kwargs)
            returnjson.dumps(result,indent=indent,sort_keys=sort_keys)
        returninner
    ifdecorated_:
        returnactual_decorator(decorated_)
    else:
        returnactual_decorator
 
 
@json_output(indent=4)
def f1():
    return{'status': 'done'}
 
@json_output
def f2():
    return{'status': 'done'}
 
@json_output()
def f3():
    return{'status': 'done'}
 
print f1()
print f2()
print f3()

代码中关键的地方在于 json_output 在最后对参数 decorated 进行了判断，有的话证明是不传参调用，那么直接返回 actual_decorator 的调用；没有的话则代表是传参类型的调用（虽然参数可能不存在），那么返回 actual_decorator 。其中有点需要注意， josn_output 的传参需要使用关键字参数，如果像下面这样直接传一个位置参数，那么根据现在的实现会出现错误（因为它会被当成 decorated_ ）。

@json_output(4)  #错误的使用方法
def f4():
    return{'status': 'done'}
