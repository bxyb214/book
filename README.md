
## Build with

- Ruby 2.1.1 and Rails 4.1.1
- Postgresql 9.1+ for databsae
- elasticsearch 1.0+ for full text searching
- Redis for backgound jobs
- memcached for cache
- postfix(through SMTP) for sending system email

The best deploy environment is Ubuntu 14.04 LTS, require at least 1G memory.

## Setup

- script/environment.sh to install required software
- script/setup.sh to configure Passenger and Nginx

## Gems

- SCSS for stylesheets
- Uglifier as compressor for JavaScript assets
- jquery as the JavaScript library
- Turbolinks makes following links in your web application faster.
- Bootstrap and Font Awesome
- Slim for template
- redcarpet for Markdown
- carrierwave for file upload
- capistrano for Deploy
- pry for debug
- cucumber for auto test


## License

MIT License.
