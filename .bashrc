#PATH
export PATH=~/.bin/floorp:$PATH
export PATH=~/.bin/Telegram:$PATH
#ALIAS
alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias du='du -kh'
alias df='df -kTh'
# ls предполагается, что установлена GNU ls
alias la='ls -Al'               # показать скрытые файлы
alias ls='ls -hF --color'       # выделить различные типы файлов цветом
alias lx='ls -lXB'              # сортировка по расширению
alias lk='ls -lSr'              # сортировка по размеру
alias lc='ls -lcr'              # сортировка по времени изменения
alias lu='ls -lur'              # сортировка по времени последнего обращения
alias lr='ls -lR'               # рекурсивный обход подкаталогов
alias lt='ls -ltr'              # сортировка по дате
alias lm='ls -al |more'         # вывод через 'more'
alias tree='tree -Csu'          # альтернатива 'ls'

# Разные утилиты:

function repeat()       # повторить команду n раз
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-подобный синтаксис
        eval "$@";
    done
}

