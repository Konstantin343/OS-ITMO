
#!/bin/bash

host="www.nikogo_net.ru"

touch ~/report
mkdir ~/test \
  && echo "catalog test was created successfully" >> ~/report \
  && touch ~/test/$(date '+%d.%m.%y_%H:%M:%S')
ping "${host}" \
  || echo "${host} is not available" >> ~/report

