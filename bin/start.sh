#!/bin/sh

bin/gscraper eval "Gscraper.ReleaseTasks.migrate()"

bin/gscraper start
