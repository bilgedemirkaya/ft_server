# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bdemirka <bdemirka@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/24 11:20:54 by bdemirka          #+#    #+#              #
#    Updated: 2021/04/24 11:20:54 by bdemirka         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

COPY srcs /tmp/

RUN apt-get update && apt-get install -y \
    nginx \
    mariadb-server \
    php-fpm \
    php-mysql \
    php-mbstring \
    wget \
    && rm -rf /var/lib/apt/lists/*

CMD bash /tmp/initial.sh