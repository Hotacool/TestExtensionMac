# TestExtensionMac

Xcode8 中取消了plugin，原有的第三方插件全部无法使用。取而代之的，Apple提供了名为Xcode Source Editor Extension的新技术，可以通过为Xcode开发extension的方式，来实现原来插件的功能。因为是新技术，所以功能上你懂的...

该demo实现了类似VVDocumenter功能，自动生成方法注释。主要目的是体验Xcode Source Editor Extension这个新技术，所以功能上非常简单。

##How to use
[Xcode Source Editor Extension](http://www.jianshu.com/p/054af8b3cb60)

另外注意mac app 和 extension的签名信息要保持一致。
