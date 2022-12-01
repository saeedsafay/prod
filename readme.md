Novinnaghsh website project
===================
Based on [CodeIgniter Framework](http://www.codeigniter.com).

#### Note
This branch is a developed branch for switching to CodeIgniter3 And integrating with Eloquent ORM and installing smarty
 template engine.

#### Used Libraries


- [CodeIgniter Modular extensions HMVC](https://bitbucket.org/wiredesignz/codeigniter-modular-extensions-hmvc)
- [illuminate Eloquent ORM](http://http://laravel.com/docs/5.1/eloquent)
- [Cartalyst Sentinel Auth](https://https://cartalyst.com/manual/sentinel/2.0)
- [Smarty Template Engine](https://github.com/pyrocms/lex)

#### Features
- User Management
- Sentinel Authentication
- Eloquent ORM
- Smarty Template Engine
- Composer friendly
- Dynamic Menus
- Shop
- Material Design admin panel
- More ...

### Using migration
#### create a new migration file:
````bash
bash novin.bash make $module $fileName [test_table]
````
#### run migration up:
````bash
bash novin.bash up $module
````