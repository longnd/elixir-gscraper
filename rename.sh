current_otp="gscraper_web" 
current_name="GscraperWeb"
new_otp="gscraper"
new_name="Gscraper"

git grep -l $current_otp | xargs sed -i '' -e 's/'$current_otp'/'$new_otp'/g'
git grep -l $current_name | xargs sed -i '' -e 's/'$current_name'/'$new_name'/g'
mv ./lib/$current_otp ./lib/$new_otp
mv ./lib/$current_otp.ex ./lib/$new_otp.ex
mv ./test/$current_otp ./test/$new_otp
