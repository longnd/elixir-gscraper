#!/bin/sh

bin/gscraper_web eval "GscraperWeb.ReleaseTasks.migrate()"

bin/gscraper_web start
