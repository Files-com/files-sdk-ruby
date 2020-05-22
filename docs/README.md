# [Files.com API Documentation](https://developers.files.com/)

This is the Files.com API documentation website. It uses Vae for hosting, and is generated from markdown using [Slate](https://github.com/lord/slate).

- [Local Development Setup](#local-development-setup)
- [Building for Deployment](#building-for-deployment)
- [References](#references)

## Local Development Setup

Install Middleman and dependencies

`bundle install`

Start Middleman server

`bundle exec middleman server`

You can now access the site at [http://localhost:4567](http://localhost:4567/).

## Building for Deployment

Middleman will build the static HTML website to the `build` directory

`bundle exec middleman build --clean`

### References

* [Editing Slate Markdown](https://github.com/lord/slate/wiki/Markdown-Syntax)
* [Supported Languages](https://github.com/jneen/rouge/wiki/List-of-supported-languages-and-lexers)
