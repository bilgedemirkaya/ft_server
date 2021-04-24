# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    autoindex.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bdemirka <bdemirka@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/24 19:23:37 by bdemirka          #+#    #+#              #
#    Updated: 2021/04/24 21:30:44 by bdemirka         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if grep -q "autoindex on" /etc/nginx/sites-enabled/localhost;
then
	sed -i 's/autoindex on/autoindex off/g' /etc/nginx/sites-enabled/localhost
	echo "autoindex off"
	service nginx restart

elif grep -q "autoindex off" /etc/nginx/sites-enabled/localhost;
then
	sed -i 's/autoindex off/autoindex on/g' /etc/nginx/sites-enabled/localhost
	echo "autoindex on"
	service nginx restart
fi
