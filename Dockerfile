FROM ubuntu:18.04

RUN apt -y update
RUN apt install -y nodejs
RUN apt install -y npm
RUN npm install -g elm
RUN npm install http-server -g
RUN npm install --global uglify-js

COPY . ./
RUN elm make src/Main.elm --output elm.js --optimize
RUN uglifyjs elm.js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters=true,keep_fargs=false,unsafe_comps=true,unsafe=true,passes=2' --output=elm.js && uglifyjs elm.js --mangle --output=elm.js

EXPOSE 8069

CMD http-server -p 8069