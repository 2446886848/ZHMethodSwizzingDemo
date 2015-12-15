# ZHMethodSwizzingDemo

##demo是对写好的一个NSObject的methodSwizzing分类进行的测试代码。
替换主要是使用ClassB的funcB方法来替换ClassA的funcA方法，然后调用ClassA的funcA方法来查看是否替换成功。

##使用方法，包含两个NSObject+方法，例子：

实例方法的替换（-方法）<br>
    [NSObject zh_swizzleClass:[ClassA class] original:@selector(funcA) withSwizzedClass:[ClassB class] swizzledSelector:@selector(funcB)];

类方法的替换 （+方法）<br>
        [NSObject zh_swizzleMetaClass:[ClassA class] original:@selector(funcA) withSwizzedClass:[ClassB class] swizzledSelector:@selector(funcB)];
##分别测试了不同场景下的使用结果，测试场景如下：

condition1: ClassB dosen't have funcB<br> 
expect: swizze failed<br>
result：swizze failed

condition2: ClassA has nothing, ClassB has funcB<br> 
expect: ZHClassBCondition2 funcB<br>
result：swizze sucess

condition3: ClassA has funcA, ClassB has funcB<br> 
expect: ZHClassBCondition3 funcB + ZHClassACondition3 funcA<br>
result：swizze sucess

condition4: ClassA has funcB, ClassB has funcB<br> 
expect: ZHClassBCondition4 funcB<br>
result：swizze sucess

condition5: ClassA has funcA and funcB, ClassB has funcB<br> 
expect: class:ZHClassACondition5 already has method:funcB + ZHClassACondition5 funcA<br>
result：swizze failed

condition6: ClassA has funcA:, ClassB has funcB<br> 
expect: Trying to swizze methods with different typeEncodeing + ZHClassACondition6 funcA str = aaa<br>
result：swizze failed
    
testClassMethodSwizzing: classMehtod swizzing<br> 
expect: ZHClassBCondition7 funcB<br>
result：swizze sucess

testClassMethodSwizzing: swizz class method with instance method<br> 
expect: ZHClassBCondition6 funcB  <br>
result：swizze sucess
