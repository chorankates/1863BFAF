#!/usr/bin/env php

<?php
# h/t http://stackoverflow.com/a/17058314

$meta_url = 'http://1863BFAF.pwnz.org:4567/meta';

# TODO isn't this just shelling out to curl? god this language is absurd
$ch = curl_init();
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_URL,$meta_url);

$meta_content = curl_exec($ch);
$urls = explode(',', $meta_content);

foreach ($urls as $url) {
  $url = str_replace('[', '', $url);
  $url = str_replace(']', '', $url);
  $url = str_replace('"', '', $url);
  echo "-> $url\n";
  curl_setopt($ch, CURLOPT_URL, $url);
  if (curl_exec($ch) == false) {
    # TODO make this actually expose the error message
    echo "ERROR: " . curl_error($ch);
    exit(1);
  }

}

exit(0);
?>