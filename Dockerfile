FROM ruby:3.2.2-alpine3.18
RUN apk update && apk add \
    build-base tzdata git sqlite sqlite-dev zsh wget \
    nano curl font-meslo-nerd shadow zsh-vcs yarn

ENV APP_HOME /app
WORKDIR $APP_HOME

RUN git init
RUN git remote add origin https://github.com/leandrolasnor/wkm
RUN git pull origin master
RUN git checkout master -f
RUN git branch --set-upstream-to origin/master

RUN gem install bundler --version '2.4.19'
RUN bundle
RUN yarn --cwd ./reacting install

COPY entrypoint.sh /usr/bin/
RUN dos2unix /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN rm -rf /root/.oh-my-zsh
RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN usermod --shell /bin/zsh root
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
RUN sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc 
RUN sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=powerlevel10k\/powerlevel10k/g' ~/.zshrc
