# What is HUGE?

Just a simple user authentication solution inside a super-simple MVC framework skeleton that works out-of-the-box. HUGE uses the future-proof official bcrypt password hashing/salting implementation of PHP 5.5+, plus has some nice features that will dramatically speed up the time from idea to first usable prototype application. That's all. This project has its focus on hardcore simplicity. Everything is as simple as possible, made for smaller projects, typical agency work and quick pitch drafts. If you want to build massive corporate applications with all the features modern frameworks have, then have a look at [Laravel](http://laravel.com/), [Symfony](http://symfony.com/) or [Yii](http://www.yiiframework.com/), but if you just want to quickly create something that just works, then this script might be interesting for you.

HUGE's simple-as-possible architecture was inspired by several conference talks, slides and articles about huge applications that - surprisingly and intentionally - go back to the basics of programming, using procedural programming, static classes, extremely simple constructs, not-totally-DRY code etc. while keeping the code extremely readable ([StackOverflow](http://www.dev-metal.com/architecture-stackoverflow/), Wikipedia, SoundCloud).

> [github.com/panique/huge](https://github.com/panique/huge)

![HUGE logo](https://raw.githubusercontent.com/knickers/huge/master/huge-logo.png)

# How to use this image

Copy the example configuration file from here: [github.com/knickers/huge](https://github.com/knickers/huge/blob/master/config.example.php) and make any changes you need.

```console
$ docker run -d -e MYSQL_ROOT_PASSWORD="example_password" --name huge-db knickers/huge-db
$ docker run --link huge-db:mysql -p 8080:80 -v config.php:/var/www/html/application/config/config.development.php knickers/huge
```

`knickers/huge-db` is a MariaDB database pre-seeded with the `users` table needed by the HUGE framework, [here is the source](https://github.com/knickers/huge-db).

## Use in development

In order to mount your development files in the container without overwriting any core framework files, you must mount each folder individually.

```console
$ docker run -it --rm \
	-v src/application/config:/var/www/html/application/config \
	-v src/application/controller:/var/www/html/application/controller \
	-v src/application/model:/var/www/html/application/model \
	-v src/application/view:/var/www/html/application/view \
	-v src/public/css:/var/www/html/public/css \
	-v src/public/js:/var/www/html/public/js \
	knickers/huge
```

## Use in production

Compile your own image, the `COPY` command does a merge, so the core framework files are not overwritten.

```dockerfile
FROM knickers/huge

COPY src:/var/www/html/
```
