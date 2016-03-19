# What is HUGE?

Just a simple user authentication solution inside a super-simple framework skeleton that works out-of-the-box (and comes with an auto-installer), using the future-proof official bcrypt password hashing/salting implementation of PHP 5.5+, plus some nice features that will speed up the time from idea to first usable prototype application dramatically. Nothing more. This project has its focus on hardcore simplicity. Everything is as simple as possible, made for smaller projects, typical agency work and quick pitch drafts. If you want to build massive corporate applications with all the features modern frameworks have, then have a look at [Laravel](http://laravel.com/), [Symfony](http://symfony.com/) or [Yii](http://www.yiiframework.com/), but if you just want to quickly create something that just works, then this script might be interesting for you.

HUGE's simple-as-possible architecture was inspired by several conference talks, slides and articles about huge applications that - surprisingly and intentionally - go back to the basics of programming, using procedural programming, static classes, extremely simple constructs, not-totally-DRY code etc. while keeping the code extremely readable ([StackOverflow](http://www.dev-metal.com/architecture-stackoverflow/), Wikipedia, SoundCloud).

> [HUGE](https://github.com/panique/huge)

![HUGE logo](https://raw.githubusercontent.com/knickers/huge/master/huge-logo.png)

# How to use this image

```console
$ docker run -d -e MYSQL_ROOT_PASSWORD="example password" --name huge-db knickers/huge-db
$ docker run --link huge-db:mysql -p 8080:80 knickers/huge
```
