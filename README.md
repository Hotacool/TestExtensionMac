# TestExtensionMac

Xcode8 中取消了plugin，原有的第三方插件全部无法使用。取而代之的，Apple提供了名为Xcode Source Editor Extension的新技术，可以通过为Xcode开发extension的方法，完成辅助功能。虽然目前该技术功能还很有限，无法取代原第三方插件的全部功能，不过也是Apple逐渐开放的一种体现吧...

该demo实现了类似VVDocumenter功能，自动生成方法注释。主要目的是体验Xcode Source Editor Extension这个新技术，所以功能上非常简单。

##How to use
参考链接
[How to Create an Xcode Source Editor Extension](https://www.baidu.com/link?url=JsmYC3ve2sFzXj8Ao8d-jd9VjVmU9XTadyjFukpXgMJGekADXW-iLCsgkfzut5xnH_njbho2YAbanOyxIEd8JaEg6vW8iXO2Gn_U3xK6fZeMBb83y4aFgvAD2du3HAfYE5Y6Fk49Pgd1Yj17QLqx__&wd=&eqid=91e572490001c19c00000004580d6886)
