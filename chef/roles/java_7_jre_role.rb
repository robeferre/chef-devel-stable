name "java_7_jre"
description "IBM JRE Java Technology Edition Version 7"
run_list(
     "recipe[java_7_jre::install]"
  )
